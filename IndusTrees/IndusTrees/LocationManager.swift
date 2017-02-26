//
//  LocationManager.swift
//  MindTheMap
//
//  Created by Antonio Antonino on 25/02/2017.
//  Copyright © 2017 A16. All rights reserved.
//


import Foundation
import CoreLocation
import UIKit

protocol TaskRegionListener: class {
    func manager(_ locationManager: LocationManager, didFindTaskCreatedWithId taskId: UInt16, forUser userId: UInt16)
    func manager(_ locationManager: LocationManager, didFindTaskCompletedWithId taskId: UInt16, forUser userId: UInt16)
    func manager(_ locationManager: LocationManager, didFindTaskValidatedWithId taskId: UInt16, forUser userId: UInt16)
}

protocol PresenceRegionListener: class {
    func manager(_ locationManager: LocationManager, didFindPresenceRegion: CLBeaconRegion)
    func manager(_ locationManager: LocationManager, didReceivePresenceUpdateFromUser userId: UInt16)
}

protocol LocationChangeDelegate: class {
    func locationDidChange(to newStatus: CLAuthorizationStatus)
}

class LocationManager: NSObject {
    
    static let MAXIMUM_TIME_CACHE = 60.0    //60 s
    
    fileprivate var manager: CLLocationManager!
    //Used to give back to client the result of the permission alert shown when the GPS is required for the first time to the OS
    fileprivate var askForPermissionsCompletionHandler: ((Bool) -> Void)?
    
    fileprivate lazy var regionsMonitored: [CLBeaconRegion] = []
    
    fileprivate lazy var regionNotifications: [UUID: [UInt16]] = [:]
    
    weak var tasksDelegate: TaskRegionListener?
    weak var presenceDelegate: PresenceRegionListener?
    
    fileprivate struct AdditionalRegions {
        static let BEACON_PRESENCE_FOUND = UUID(uuidString: "33EFC68F-7042-4BB6-B0B2-A0A5C8637A76")!
    }
    
    //Delegate to which the change in the GPS permissions are communicated
    weak var delegate: LocationChangeDelegate?
    
    static let shared: LocationManager = {
        let man = LocationManager()
        man.manager.delegate = man
        
        return man
    }()
    
    var monitoredRegions: Set<CLRegion> {
        return self.manager.monitoredRegions
    }
    
    private override init() {
        super.init()
        
        self.manager = CLLocationManager()
        self.manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.manager.distanceFilter = 100   //100 m
        
        self.regionsMonitored = [
            CLBeaconRegion(proximityUUID: LocationManager.AdditionalRegions.BEACON_PRESENCE_FOUND, identifier: "it.cheerios"),
            CLBeaconRegion(proximityUUID: BluetoothManager.BeaconRegions.TASK_ADDED, identifier: "it.cheerios2"),
            CLBeaconRegion(proximityUUID: BluetoothManager.BeaconRegions.TASK_COMPLETED, identifier: "it.cheerios3"),
            CLBeaconRegion(proximityUUID: BluetoothManager.BeaconRegions.TASK_VALIDATED, identifier: "it.cheerios4"),
            CLBeaconRegion(proximityUUID: BluetoothManager.BeaconRegions.PRESENCE_REGISTERED, identifier: "it.cheerios5")
        ]
    }
    
    func startMonitoringForBeaconRegions() {
        self.regionsMonitored.forEach({ region in
            self.manager.startMonitoring(for: region)
        })
    }
    
    func stopMonitoringForBeaconRegion(_ region: CLBeaconRegion) {
        self.manager.stopMonitoring(for: region)
    }
    
    func getLastKnownLocation() -> CLLocation? {
        return self.manager.location
    }
    
    func authorizationStatus() -> CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    func askForPermission(completionHandler: ((Bool) -> Void)?) {
        self.askForPermissionsCompletionHandler = completionHandler
        self.manager.requestAlwaysAuthorization()
    }
    
    //Asks the user to open the settings app in order to turn on localization for the app.
    func getPermissionsAlertController() -> UIAlertController {
        let enableGPSAlertController = UIAlertController(title: "Location services should be ON", message: "In order for MindTheMap to work best, location services should be ON for the app. This will not affect in any way on the battery of your device", preferredStyle: .alert)
        let openAppSettingsAction = UIAlertAction(title: "Go to settings", style: .default) { action in
            //The handler of this operation is to store locally both the handler and the action
            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        enableGPSAlertController.addAction(openAppSettingsAction)
        enableGPSAlertController.addAction(cancelAction)
        
        return enableGPSAlertController
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    //If it is the first time the location is asked, then an handler is called, otherwise the delegate's method is called after the user has gone into the settings app to change the privacy settings.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .notDetermined {
            self.askForPermissionsCompletionHandler?(status == .authorizedAlways)
            self.delegate?.locationDidChange(to: status)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Starting ranging beacons")
        self.regionNotifications[(region as! CLBeaconRegion).proximityUUID]?.removeAll()
        manager.startRangingBeacons(in: region as! CLBeaconRegion)
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { _ in
            print("Stopping ranging beacons")
            manager.stopRangingBeacons(in: region as! CLBeaconRegion)
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Exit from region")
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("Manager started monitoring for region: \(region)")
        print(self.monitoredRegions)
    }
    
    //Since this method gets called every second, we need to keep trace of the reports already handled (if more than one report at every speciic time)
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print("Manager ranged beacons: \(beacons)")
        let existingBeacons = self.regionNotifications[region.proximityUUID]
        let newBeaconsForRegion = beacons.filter({ beacon in
            return existingBeacons == nil || !existingBeacons!.contains(UInt16(beacon.major))
        })
        print(newBeaconsForRegion)
        newBeaconsForRegion.forEach({ beacon in
            switch region.proximityUUID {
            case BluetoothManager.BeaconRegions.TASK_ADDED, BluetoothManager.BeaconRegions.TASK_COMPLETED, BluetoothManager.BeaconRegions.TASK_VALIDATED:
                if let delegate = self.tasksDelegate {
                    switch region.proximityUUID {
                    case BluetoothManager.BeaconRegions.TASK_ADDED:
                        delegate.manager(self, didFindTaskCreatedWithId: UInt16(beacon.major), forUser: UInt16(beacon.minor))
                    case BluetoothManager.BeaconRegions.TASK_COMPLETED:
                        delegate.manager(self, didFindTaskCompletedWithId: UInt16(beacon.major), forUser: UInt16(beacon.minor))
                    case BluetoothManager.BeaconRegions.TASK_VALIDATED:
                        delegate.manager(self, didFindTaskValidatedWithId: UInt16(beacon.major), forUser: UInt16(beacon.minor))
                    default:
                        break
                    }
                }
            case LocationManager.AdditionalRegions.BEACON_PRESENCE_FOUND, BluetoothManager.BeaconRegions.PRESENCE_REGISTERED:
                if let delegate = self.presenceDelegate {
                    switch region.proximityUUID {
                    case LocationManager.AdditionalRegions.BEACON_PRESENCE_FOUND:
                        delegate.manager(self, didFindPresenceRegion: region)
                    case BluetoothManager.BeaconRegions.PRESENCE_REGISTERED:
                        delegate.manager(self, didReceivePresenceUpdateFromUser: UInt16(beacon.major))
                    default:
                        break
                    }
                }
            default:
                break
            }
            //If there was no previous beacon in the region, a new array is assigned to that key, otherwise it is added to the already existing
            self.regionNotifications[region.proximityUUID] = existingBeacons == nil ? [UInt16(beacon.major)] : (existingBeacons! + [UInt16(beacon.major)])
        })
    }
}

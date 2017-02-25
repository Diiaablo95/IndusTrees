//
//  LocationManager.swift
//  MindTheMap
//
//  Created by Antonio Antonino on 25/02/2017.
//  Copyright © 2017 A16. All rights reserved.
//

import Foundation
import CoreLocation

protocol TaskRegionListener: class {
    func manager(_ locationManager: LocationManager, didFindTaskCreatedWithId taskId: UInt16)
    func manager(_ locationManager: LocationManager, didFindTaskCompletedWithId taskId: UInt16)
    func manager(_ locationManager: LocationManager, didFindTaskValidatedWithId taskId: UInt16)
}

protocol PresenceRegionListener: class {
    func manager(_ locationManager: LocationManager, didFindPresenceRegion: CLBeaconRegion)
    func manager(_ locationManager: LocationManager, didReceivePresenceUpdateFromUser userId: UInt16)
}

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    private var locationManager: CLLocationManager!
    
    weak var tasksDelegate: TaskRegionListener?
    weak var presenceDelegate: PresenceRegionListener?
    
    fileprivate lazy var regionNotifications: [UUID: [CLBeacon]] = [:]
    
    fileprivate struct AdditionalRegions {
        static let BEACON_PRESENCE_FOUND = UUID(uuidString: "33EFC68F-7042-4BB6-B0B2-A0A5C8637A76")!
    }
    
    override private init() {}
    
    func setup() {
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        
        self.locationManager.requestAlwaysAuthorization()
    }
    
    func startMonitoringForBeaconRegions() {
        self.locationManager.startMonitoring(for: CLBeaconRegion(proximityUUID: BluetoothManager.BeaconRegions.TASK_ADDED, identifier: "it.cheerios"))
        
//        self.locationManager.startMonitoring(for: CLBeaconRegion(proximityUUID: BluetoothManager.BeaconRegions.TASK_COMPLETED, identifier: "it.cheerios"))
//        
//        self.locationManager.startMonitoring(for: CLBeaconRegion(proximityUUID: BluetoothManager.BeaconRegions.TASK_VALIDATED, identifier: "it.cheerios"))
//        
//        self.locationManager.startMonitoring(for: CLBeaconRegion(proximityUUID: BluetoothManager.BeaconRegions.PRESENCE_REGISTERED, identifier: "it.cheerios"))
//        
//        self.locationManager.startMonitoring(for: CLBeaconRegion(proximityUUID: LocationManager.AdditionalRegions.BEACON_PRESENCE_FOUND, identifier: "it.cheerios"))
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    private func matchRegionId(_ region: CLBeaconRegion) -> String {
        let id = region.proximityUUID
        
        switch id {
        case BluetoothManager.BeaconRegions.PRESENCE_REGISTERED:
            return "Region coming from a request for presence register"
        case BluetoothManager.BeaconRegions.TASK_ADDED:
            return "Region coming from a new task addition"
        case BluetoothManager.BeaconRegions.TASK_COMPLETED:
            return "Region coming from a new task completion"
        case BluetoothManager.BeaconRegions.TASK_VALIDATED:
            return "Region coming from a new task validation"
        case LocationManager.AdditionalRegions.BEACON_PRESENCE_FOUND:
            return "Region coming from a new presence beacon found"
        default:
            return "Region with unknown UUID."
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Entered region: \(region)")
        if let region = region as? CLBeaconRegion {
            print("Matched region description: '\(self.matchRegionId(region))'")
            self.regionNotifications[region.proximityUUID]?.removeAll()
            manager.startRangingBeacons(in: region)
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { _ in
                print("Stopping ranging for beacons in region: \(region)")
                manager.stopRangingBeacons(in: region)
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Exited region: \(region)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Manager failed with error: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("Manager started monitoring for region: \(region)")
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print("Manager ranged beacons: \(beacons)")
        let existingBeacons = self.regionNotifications[region.proximityUUID]
        let newBeaconsForRegion = beacons.filter({ beacon in
            return existingBeacons == nil || !existingBeacons!.contains(beacon)
        })
        newBeaconsForRegion.forEach({ beacon in
            switch region.proximityUUID {
            case BluetoothManager.BeaconRegions.TASK_ADDED, BluetoothManager.BeaconRegions.TASK_COMPLETED, BluetoothManager.BeaconRegions.TASK_VALIDATED:
                if let delegate = self.tasksDelegate {
                    switch region.proximityUUID {
                    case BluetoothManager.BeaconRegions.TASK_ADDED:
                        delegate.manager(self, didFindTaskCreatedWithId: region.major as! UInt16)
                    case BluetoothManager.BeaconRegions.TASK_COMPLETED:
                        delegate.manager(self, didFindTaskCompletedWithId: region.major as! UInt16)
                    case BluetoothManager.BeaconRegions.TASK_VALIDATED:
                        delegate.manager(self, didFindTaskValidatedWithId: region.major as! UInt16)
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
                        delegate.manager(self, didReceivePresenceUpdateFromUser: region.major as! UInt16)
                    default:
                        break
                    }
                }
            default:
                break
            }
            //If there was no previous beacon in the region, a new array is assigned to that key, otherwise it is added to the already existing
            self.regionNotifications[region.proximityUUID] = existingBeacons == nil ? [beacon] : (existingBeacons! + [beacon])
        })
    }
    
    func locationManager(_ manager: CLLocationManager, rangingBeaconsDidFailFor region: CLBeaconRegion, withError error: Error) {
        print("Manager failed ranging beacons with error: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Manager failed monitoring for region: \(region) with error: \(error.localizedDescription)")
    }
}

//
//  AppDelegate.swift
//  IndusTrees
//
//  Created by Alberto Saltarelli on 25/02/2017.
//  Copyright © 2017 CheeriOS. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        BluetoothManager.shared.setup()
        NotificationManager.shared.setup()
        LocationManager.shared.askForPermission(completionHandler: { result in
            if result {
                LocationManager.shared.startMonitoringForBeaconRegions()
            }
        })
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        return true
    }

}

extension AppDelegate: PresenceRegionListener {
    
    func manager(_ locationManager: LocationManager, didReceivePresenceUpdateFromUser userId: UInt16) {
        NotificationManager.shared.shced
    }

    
    func manager(_ locationManager: LocationManager, didFindPresenceRegion: CLBeaconRegion) {
        BluetoothManager.shared.sendNotificationForPresenceToRegister(forUserId: LoginManager.shared.userId!)
    }

    
}

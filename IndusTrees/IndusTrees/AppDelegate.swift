//
//  AppDelegate.swift
//  IndusTrees
//
//  Created by Alberto Saltarelli on 25/02/2017.
//  Copyright © 2017 CheeriOS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        MyLocationManager.shared.askForPermission(completionHandler: { result in
            if result {
                MyLocationManager.shared.startMonitoringForBeaconRegions()
            }
        })
        
        return true
    }

}


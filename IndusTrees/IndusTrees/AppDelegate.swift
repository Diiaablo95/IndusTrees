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
//        
//        if let id = LoginManager.shared.userId {
//            if DataStore.employee(with: id) != nil {
//                let mainController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tlProjectsController") as! TLProjectsController
//                let previousRootController = self.window?.rootViewController
//                self.window?.rootViewController = mainController
//                previousRootController?.dismiss(animated: false, completion: nil)
//            } else if DataStore.teamLeader(with: id) != nil {
//                let mainController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmployeeMenuController") as! EmployeeMenuController
//                let previousRootController = self.window?.rootViewController
//                self.window?.rootViewController = mainController
//                previousRootController?.dismiss(animated: false, completion: nil)
//            }
//        }
//        
        UIApplication.shared.statusBarStyle = .lightContent
        
        return true
    }

}


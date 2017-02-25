//
//  ViewController.swift
//  IndusTrees
//
//  Created by Alberto Saltarelli on 25/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BluetoothManager.shared.setup()
        NotificationManager.shared.setup()
        LocationManager.shared.setup()
        
        LocationManager.shared.startMonitoringForBeaconRegions()
        LocationManager.shared.tasksDelegate = self
    }
    
    @IBAction func onCreateTask(_ sender: UIButton) {
        BluetoothManager.shared.sendNotificationForTaskAdded(taskId: 10)
    }
    
    @IBAction func onCompleteTask(_ sender: UIButton) {
        BluetoothManager.shared.sendNotificationForTaskCompleted(taskId: 15)
    }
    
    @IBAction func onVerifyTask(_ sender: UIButton) {
        BluetoothManager.shared.sendNotificationForTaskValidated(taskId: 20)
    }
}

extension ViewController: TaskRegionListener {
    
    func manager(_ locationManager: LocationManager, didFindTaskCreatedWithId taskId: UInt16) {
        NotificationManager.shared.scheduleNotificationForTaskAdded(withUserId: taskId)
    }

    func manager(_ locationManager: LocationManager, didFindTaskCompletedWithId taskId: UInt16) {
        NotificationManager.shared.scheduleNotificationForTaskCompleted(withTaskId: taskId)
    }
    
    func manager(_ locationManager: LocationManager, didFindTaskValidatedWithId taskId: UInt16) {
        NotificationManager.shared.scheduleNotificatonForTaskValidated(withTaskId: taskId)
    }
    
}

//
//  ViewController.swift
//  IndusTrees
//
//  Created by Alberto Saltarelli on 25/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyLocationManager.shared.askForPermission(completionHandler: { result in
            if result {
                MyLocationManager.shared.tasksDelegate = self
                MyLocationManager.shared.startMonitoringForBeaconRegions()
            }
        })
        NotificationManager.shared.setup()
        BluetoothManager.shared.setup()
    }
    
    @IBAction func onCreateTask(_ sender: UIButton) {
        BluetoothManager.shared.sendNotificationForTaskAdded(taskId: 10, forUserId: 12)
    }
    
    private func sendTask(_ task: Task) {
        let taskId = task.bid
        task.employees?.forEach({ employee in
            BluetoothManager.shared.sendNotificationForTaskAdded(taskId: taskId, forUserId: employee.account.bid)
        })
    }
    
    @IBAction func onCompleteTask(_ sender: UIButton) {
        BluetoothManager.shared.sendNotificationForTaskCompleted(taskId: 15, forUserId: 12)
    }
    
    private func completeTask(_ task: Task) {
        if let employees = task.employees, let employee = employees.first {
            let leaderId = employee.teamLeader!.account.bid
            let taskId = task.bid
            BluetoothManager.shared.sendNotificationForTaskCompleted(taskId: taskId, forUserId: leaderId)
        }
    }
    
    @IBAction func onVerifyTask(_ sender: UIButton) {
        BluetoothManager.shared.sendNotificationForTaskValidated(taskId: 20, forUserId: 12)
    }
    
    private func validateTask(_ task: Task) {
        let taskId = task.bid
        task.employees?.forEach({ employee in
            BluetoothManager.shared.sendNotificationForTaskValidated(taskId: taskId, forUserId: employee.account.bid)
        })
    }
}

extension ViewController: TaskRegionListener {
    
    func manager(_ locationManager: MyLocationManager, didFindTaskCreatedWithId taskId: UInt16, forUser userId: UInt16) {
        
    }

    func manager(_ locationManager: MyLocationManager, didFindTaskCompletedWithId taskId: UInt16, forUser userId: UInt16) {
        <#code#>
    }
    
    func manager(_ locationManager: MyLocationManager, didFindTaskValidatedWithId taskId: UInt16, forUser userId: UInt16) {
        <#code#>
    }
    
}

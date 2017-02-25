//
//  BluetoothManager.swift
//  MindTheMap
//
//  Created by Antonio Antonino on 25/02/2017.
//  Copyright © 2017 A16. All rights reserved.
//

import Foundation
import CoreBluetooth
import CoreLocation

class BluetoothManager: NSObject {
    
    struct BeaconRegions {
        static let TASK_ADDED = UUID(uuidString: "0A88424F-AE0E-4209-BB27-28DF039C1E2E")!
        static let TASK_COMPLETED = UUID(uuidString: "BF91D0B6-9B3C-4D91-ABA4-E55929B5934F")!
        static let TASK_VALIDATED = UUID(uuidString : "8CF1CAE8-9DCC-49B0-AA78-B092FA88C1AE")!
        static let PRESENCE_REGISTERED = UUID(uuidString: "2D348DD5-C0CE-4AA2-BE86-D5710DAA5B08")!
    }
    
    static let shared = BluetoothManager()
    
    fileprivate var peripheralManager: CBPeripheralManager!
    
    func setup() {
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    override private init() {}
}

//MARK: Send bluetooth messages
extension BluetoothManager {
    
    func sendNotificationForTaskAdded(taskId: UInt16) {
        //OMG what the fuck is this code!?!?
        while self.peripheralManager.state != .poweredOn {
            continue
        }
        print("Sending notification for task created with id: \(taskId)")
        
        let beaconRegion = CLBeaconRegion(proximityUUID: BeaconRegions.TASK_ADDED, major: taskId, identifier: "it.cheerios")
        let peripheralData = beaconRegion.peripheralData(withMeasuredPower: nil)
        var actualData: [String: Any] = [:]
        
        for (key, value) in peripheralData {
            actualData.updateValue(value, forKey: key as! String)
        }
        
        self.peripheralManager.startAdvertising(actualData)
    }
    
    func sendNotificationForTaskCompleted(taskId: UInt16) {
        
        //OMG what the fuck is this code!?!? Pt.2
        while self.peripheralManager.state != .poweredOn {
            continue
        }
        print("Sending notification for task completed with id: \(taskId)")
        
        let beaconRegion = CLBeaconRegion(proximityUUID: BeaconRegions.TASK_COMPLETED, major: taskId, identifier: "it.cheerios")
        let peripheralData = beaconRegion.peripheralData(withMeasuredPower: nil)
        var actualData: [String: Any] = [:]
        
        for (key, value) in peripheralData {
            actualData.updateValue(value, forKey: key as! String)
        }
        
        self.peripheralManager.startAdvertising(actualData)
    }
    
    func sendNotificationForTaskValidated(taskId: UInt16) {
        
        //OMG what the fuck is this code!?!? Pt.3
        while self.peripheralManager.state != .poweredOn {
            continue
        }
        print("Sending notification for task validated with id: \(taskId)")
        
        let beaconRegion = CLBeaconRegion(proximityUUID: BeaconRegions.TASK_VALIDATED, major: taskId, identifier: "it.cheerios")
        let peripheralData = beaconRegion.peripheralData(withMeasuredPower: nil)
        var actualData: [String: Any] = [:]
        
        for (key, value) in peripheralData {
            actualData.updateValue(value, forKey: key as! String)
        }
        
        self.peripheralManager.startAdvertising(actualData)
    }
    
    func sendNotificationForPresenceToRegister(forUserId userId: UInt16) {
        
        //OMG what the fuck is this code!?!? Pt.4
        while self.peripheralManager.state != .poweredOn {
            continue
        }
        print("Sending notification for presence to register for user with id: \(userId)")
        
        let beaconRegion = CLBeaconRegion(proximityUUID: BeaconRegions.TASK_VALIDATED, major: userId, identifier: "it.cheerios")
        let peripheralData = beaconRegion.peripheralData(withMeasuredPower: nil)
        var actualData: [String: Any] = [:]
        
        for (key, value) in peripheralData {
            actualData.updateValue(value, forKey: key as! String)
        }
        
        self.peripheralManager.startAdvertising(actualData)
    }
    
}

extension BluetoothManager: CBPeripheralManagerDelegate {
    
    public func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        print("Peripheral manager updated its state.")
    }
    
    //Send a message and stop sending it after 2 seconds
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        print("Peripheral manager started advertising")
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in
            print("Peripheral manager stopped advertising")
            peripheral.stopAdvertising()
        })
    }
}

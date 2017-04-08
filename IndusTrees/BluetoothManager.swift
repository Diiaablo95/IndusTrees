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
        static let TASK_ADDED = UUID(uuidString: "A511C90E-71BB-4490-AAE2-3EB50C2DC5BE")!
        static let TASK_COMPLETED = UUID(uuidString: "5DA2ECE3-C8D5-4C16-ADD3-2274052476CA")!
        static let TASK_VALIDATED = UUID(uuidString : "9AA615E4-84BB-4F71-B49A-F49F5D64BC29")!
        static let PRESENCE_REGISTERED = UUID(uuidString: "2D348DD5-C0CE-4AA2-BE86-D5710DAA5B08")!
    }
    
    static let shared = BluetoothManager()
    
    fileprivate var peripheralManager: CBPeripheralManager!
    
    fileprivate var beaconRegion: CLBeaconRegion?
    
    func setup() {
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    override private init() {}
}

//MARK: Send bluetooth messages
extension BluetoothManager {
    
    func sendNotificationForTaskAdded(taskId: UInt16, forUserId userId: UInt16) {
        //OMG what the fuck is this code!?!?
        while self.peripheralManager.state != .poweredOn {
            continue
        }
        print("Sending notification for task created with id: \(taskId)")
        
        self.beaconRegion = CLBeaconRegion(proximityUUID: BeaconRegions.TASK_ADDED, major: taskId, minor: userId, identifier: "it.cheerios2")
        let peripheralData = self.beaconRegion!.peripheralData(withMeasuredPower: nil)
        var actualData: [String: Any] = [:]
        
        for (key, value) in peripheralData {
            actualData.updateValue(value, forKey: key as! String)
        }
        
        self.peripheralManager.startAdvertising(actualData)
    }
    
    func sendNotificationForTaskCompleted(taskId: UInt16, forUserId userId: UInt16) {
        
        //OMG what the fuck is this code!?!? Pt.2
        while self.peripheralManager.state != .poweredOn {
            continue
        }
        print("Sending notification for task completed with id: \(taskId)")
        
        self.beaconRegion = CLBeaconRegion(proximityUUID: BeaconRegions.TASK_COMPLETED, major: taskId, minor: userId, identifier: "it.cheerio3")
        let peripheralData = self.beaconRegion!.peripheralData(withMeasuredPower: nil)
        var actualData: [String: Any] = [:]
        
        for (key, value) in peripheralData {
            actualData.updateValue(value, forKey: key as! String)
        }
        
        self.peripheralManager.startAdvertising(actualData)
    }
    
    func sendNotificationForTaskValidated(taskId: UInt16, forUserId userId: UInt16) {
        
        //OMG what the fuck is this code!?!? Pt.3
        while self.peripheralManager.state != .poweredOn {
            continue
        }
        print("Sending notification for task validated with id: \(taskId)")
        
        self.beaconRegion = CLBeaconRegion(proximityUUID: BeaconRegions.TASK_VALIDATED, major: taskId, minor: userId, identifier: "it.cheerios4")
        let peripheralData = self.beaconRegion!.peripheralData(withMeasuredPower: nil)
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
        
        self.beaconRegion = CLBeaconRegion(proximityUUID: BeaconRegions.TASK_VALIDATED, major: userId, identifier: "it.cheerios5")
        let peripheralData = self.beaconRegion!.peripheralData(withMeasuredPower: nil)
        var actualData: [String: Any] = [:]
        
        for (key, value) in peripheralData {
            actualData.updateValue(value, forKey: key as! String)
        }
        
        self.peripheralManager.startAdvertising(actualData)
    }
    
}

extension BluetoothManager: CBPeripheralManagerDelegate {
    
    public func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        print("Peripheral manager updated its state with: \(peripheral.state.rawValue).")
    }
    
    //Send a message and stop sending it after 2 seconds
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        print("Peripheral manager started advertising")
        Timer.scheduledTimer(withTimeInterval: 4, repeats: false, block: { _ in
            print("Peripheral manager stopped advertising")
            peripheral.stopAdvertising()
            self.beaconRegion = nil
        })
    }
}

//
//  BeaconViewController.swift
//  IndusTrees
//
//  Created by Andrea Vultaggio on 26/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import UIKit
import CoreBluetooth
import CoreLocation

class BeaconViewController: UIViewController {
    
    private var beaconManager: CBPeripheralManager!
    
    fileprivate let beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: "33EFC68F-7042-4BB6-B0B2-A0A5C8637A76")!, identifier: "it.cheerios")
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    private var dataToSend: [String: Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.beaconManager = CBPeripheralManager(delegate: self, queue: nil)
        
        let peripheralData = self.beaconRegion.peripheralData(withMeasuredPower: nil)
        var actualData: [String: Any] = [:]
        
        for (key, value) in peripheralData {
            actualData.updateValue(value, forKey: key as! String)
        }
        
        self.dataToSend = actualData
    }
    
    @IBAction func onBeaconPressed(_ sender: UIButton) {
        if sender.isSelected {
            print("Beacon button pressed to stop advertising")
            self.beaconManager.stopAdvertising()
        } else {
            print("Beacon button pressed to start advertising")
            self.beaconManager.startAdvertising(self.dataToSend)
        }
        sender.isSelected = !sender.isSelected
    }
    
}

extension BeaconViewController: CBPeripheralManagerDelegate {
    
    public func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        print("New status for bluetooth: \(peripheral.state)")
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        print("Peripheral manager did start advertising. \(self.beaconRegion)")
    }
}

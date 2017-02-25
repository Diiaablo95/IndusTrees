//
//  ViewController.swift
//  BeaconSimulator
//
//  Created by Antonio Antonino on 25/02/2017.
//  Copyright © 2017 diiaablo. All rights reserved.
//

import UIKit
import CoreBluetooth
import CoreLocation

let beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: "33EFC68F-7042-4BB6-B0B2-A0A5C8637A76")!, identifier: "it.cheerios")

class ViewController: UIViewController {

    private var beaconManager: CBPeripheralManager!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    private var peripheralData: [String: Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.beaconManager = CBPeripheralManager(delegate: self, queue: nil)
        
        let peripheralData = beaconRegion.peripheralData(withMeasuredPower: nil)
        var actualData: [String: Any] = [:]
        
        for (key, value) in peripheralData {
            actualData.updateValue(value, forKey: key as! String)
        }
        
        print("Peripheral data correctly set up")
    }
    
    @IBAction func onBeaconPressed(_ sender: UIButton) {
        if sender.isSelected {
            print("Beacon button pressed to stop advertising")
            self.beaconManager.stopAdvertising()
        } else {
            print("Beacon button pressed to start advertising")
            self.beaconManager.startAdvertising(self.peripheralData)
        }
        sender.isSelected = !sender.isSelected
        let image = UIImage(named: sender.isSelected ? "After Press Background" : "Static Background")
        self.backgroundImageView.image = image
    }

}

extension ViewController: CBPeripheralManagerDelegate {
    
    public func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        print("New status for bluetooth: \(peripheral.state)")
    }
}

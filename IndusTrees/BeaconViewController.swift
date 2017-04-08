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

let dateFormatterWithTime: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    return dateFormatter
}()

class BeaconViewController: UIViewController {
    
    fileprivate let beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: "33EFC68F-7042-4BB6-B0B2-A0A5C8637A76")!, identifier: "it.cheerios")
    
    private var beaconManager: CBPeripheralManager!
    
    private var dataToSend: [String: Any]!
    
    @IBOutlet weak var newEmployeeView: UIView!
    
    private var previousDelegate: PresenceRegionListener?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        LocationManager.shared.presenceDelegate = self.previousDelegate
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.beaconManager = CBPeripheralManager(delegate: self, queue: nil)
        self.previousDelegate = LocationManager.shared.presenceDelegate
        LocationManager.shared.presenceDelegate = self
        
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
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
                self.manager(LocationManager.shared, didReceivePresenceUpdateFromUser: 15)
            })
        }
        sender.isSelected = !sender.isSelected
    }
    
}

extension BeaconViewController: CBPeripheralManagerDelegate {
    
    public func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        print("New status for bluetooth: \(peripheral.state)")
    }
}

extension BeaconViewController: PresenceRegionListener {
    
    func manager(_ locationManager: LocationManager, didReceivePresenceUpdateFromUser userId: UInt16) {
        self.dateLabel.text = dateFormatterWithTime.string(from: Date())
        self.newEmployeeView.alpha = 0
        self.newEmployeeView.isHidden = false
        UIView.animate(withDuration: 1, animations: {
            self.newEmployeeView.alpha = 0.4
        }, completion: { completed in
            if completed {
                UIView.animate(withDuration: 1, delay: 1.5, options: [], animations: {
                    self.newEmployeeView.alpha = 0
                }, completion: { completed in
                    if completed {
                        self.newEmployeeView.isHidden = true
                    }
                })
            }
        })
    }

    
    func manager(_ locationManager: LocationManager, didFindPresenceRegion: CLBeaconRegion) {
        print("OK")
    }

    
}

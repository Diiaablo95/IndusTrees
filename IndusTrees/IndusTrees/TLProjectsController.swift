//
//  TLProjectsController.swift
//  IndusTrees
//
//  Created by Alberto Saltarelli on 25/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import UIKit

class TLProjectsController: UIViewController {
    
    @IBOutlet weak var projectsCollectionView: UICollectionView!
    var projectManager: ProjectManager!
    var projects: [Project] { return [projectManager.project!] }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        self.projectsCollectionView.dataSource = self
        self.projectsCollectionView.delegate = self
        
        BluetoothManager.shared.setup()
        NotificationManager.shared.setup()
        LocationManager.shared.askForPermission(completionHandler: { result in
            if result {
                LocationManager.shared.presenceDelegate = UIApplication.shared.delegate as! AppDelegate
                LocationManager.shared.startMonitoringForBeaconRegions()
            }
        })
        
        self.projectManager = DataStore.projectManager
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMenu", let destVC = segue.destination as? TLMenuController {
            let project = self.projectManager.project
            
            destVC.project = project
        }
    }
}

extension TLProjectsController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return projects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "projectCell", for: indexPath) as! ProjectCell
        
        cell.projectName.text = self.projects[indexPath.row].name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "showMenu", sender: nil)
    }
}

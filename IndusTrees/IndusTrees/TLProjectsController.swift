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
    var projects: [String] = ["MindMap", "M@"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        self.projectsCollectionView.dataSource = self
        self.projectsCollectionView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMenu", let destVC = segue.destination as? TLMenuController {
            let mySelf = DataStore.account(withId: LoginManager.shared.userId!)
            let project: Project!
            
            if let instance = mySelf as? Employee {
                project =
            }
        }
    }
}

extension TLProjectsController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return projects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "projectCell", for: indexPath) as! ProjectCell
        
        cell.projectName.text = self.projects[indexPath.row - 1]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "showMenu", sender: nil)
    }
}

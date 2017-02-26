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
    var projects: [String] = ["MindTheMap", "M@"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.projectsCollectionView.dataSource = self
        self.projectsCollectionView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TLProjectsController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return projects.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newProjectCell", for: indexPath) as! NewProjectCell
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "projectCell", for: indexPath) as! ProjectCell
        
        cell.projectName.text = self.projects[indexPath.row - 1]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == 0 {
            collectionView.insertItems(at: [indexPath])
        }
    }
}

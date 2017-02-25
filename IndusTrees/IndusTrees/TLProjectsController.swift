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
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "projectCell", for: indexPath)
        
        
        return cell
    }
}

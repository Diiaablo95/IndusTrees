//
//  EmployeeAchievmentsViewController.swift
//  IndusTrees
//
//  Created by Andrea Vultaggio on 26/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import Foundation
import UIKit

class EmployeeAchievmentsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var achievments: [Achivement]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "backTable"))
        
    }
    
}

extension EmployeeAchievmentsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(achievments.count)
        return self.achievments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "achievmentCell", for: indexPath) as! AchievmentCell
        let achivement = self.achievments[indexPath.row]
        
        cell.config(achievement: achivement)
        
        return cell
    }
}

extension EmployeeAchievmentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}

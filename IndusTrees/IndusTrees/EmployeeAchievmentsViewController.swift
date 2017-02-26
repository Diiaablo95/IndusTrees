//
//  EmployeeAchievmentsViewController.swift
//  IndusTrees
//
//  Created by Andrea Vultaggio on 26/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import Foundation
import UIKit

class EmployeeAchievmentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var achievments: [Achivement] = Mocks.achivements
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.isScrollEnabled = false
        self.tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "backTable"))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(achievments.count)
        return achievments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "achievmentCell", for: indexPath) as! AchievmentCell
        let achi = achievments[indexPath.row]
        
        cell.title.text = achi.name
        cell.intDescription.text = achi.description
        cell.badge = UIImageView(image: #imageLiteral(resourceName: "hiddenImg"))
        
        
        return cell
    }
    
}

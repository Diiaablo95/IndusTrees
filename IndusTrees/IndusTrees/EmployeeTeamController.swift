//
//  EmployeeTeamController.swift
//  IndusTrees
//
//  Created by Alberto Saltarelli on 25/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import UIKit

class EmployeeTeamController: UIViewController {
    
    
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var memberTableView: UITableView!
    
    var teamMembers: [Employee]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.memberTableView.dataSource = self
        self.memberTableView.delegate = self

        self.configureViewTitle()
    }
    
    func configureViewTitle() {
        let colors = Colors(colorTop: UIColor(red: 208/255, green: 133/255, blue: 202/255, alpha: 77/100), colorBottom: .clear)
        
        self.viewTitle.backgroundColor = .clear
        let backgroundLayer = colors.gl
        backgroundLayer.frame = self.viewTitle.frame
        self.viewTitle.layer.insertSublayer(backgroundLayer, at: 0)
    }
}

extension EmployeeTeamController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teamMembers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath) as! EmployeeCell
        
        return cell
    }
}

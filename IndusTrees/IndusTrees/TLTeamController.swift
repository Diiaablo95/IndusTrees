//
//  TeamController.swift
//  IndusTrees
//
//  Created by Alberto Saltarelli on 25/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import UIKit

class TLTeamController: UIViewController {
    
    @IBOutlet weak var memberTableView: UITableView!
    @IBOutlet weak var viewTitle: UIView!
    
    var teamMembers: [Employee]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.teamMembers = Mocks.employees
        self.memberTableView.dataSource = self
        self.memberTableView.delegate = self
        
        self.configure()
    }
    
    func configure() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        
        self.configureViewTitle()
    }
    
    func configureViewTitle() {
        let colors = Colors(colorTop: UIColor(red: 208/255, green: 133/255, blue: 202/255, alpha: 77/100), colorBottom: .clear)
        
        self.viewTitle.backgroundColor = .clear
        let backgroundLayer = colors.gl
        backgroundLayer.frame = self.viewTitle.frame
        self.viewTitle.layer.addSublayer(backgroundLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TLTeamController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teamMembers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCellPlus", for: indexPath) as! EmployeePlusCell
        
        return cell
    }
}

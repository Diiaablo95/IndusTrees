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
    @IBOutlet weak var imageTextField: UIImageView!
    
    var teamMembers: [Employee] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        self.memberTableView.dataSource = self
        self.memberTableView.delegate = self
        
        self.configure()
    }
    
    func configure() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        
    }
}

extension TLTeamController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teamMembers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCellPlus", for: indexPath) as! EmployeePlusCell
        
        cell.logo.image = self.teamMembers[indexPath.row].account.image
        cell.labelName.text = self.teamMembers[indexPath.row].account.name + " " + self.teamMembers[indexPath.row].account.surname
        
        return cell
    }
}

extension TLTeamController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.imageTextField.isHidden = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.imageTextField.isHidden = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}

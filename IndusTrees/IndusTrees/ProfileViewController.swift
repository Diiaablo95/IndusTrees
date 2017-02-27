//
//  ProfileViewController.swift
//  IndusTrees
//
//  Created by Andrea Vultaggio on 26/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var Profile: UILabel!
    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var dataNascita: UILabel!
    @IBOutlet weak var ruolo: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var xpPoints: UILabel!
    @IBOutlet weak var task: UILabel!
    
    
    @IBOutlet weak var taskImageView: UIImageView!
    
    @IBOutlet weak var teamButton: UIButton!
    @IBOutlet weak var achievementButton: UIButton!
    @IBOutlet weak var tasksButton: UIButton!
    
    private var account: Account!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.account = DataStore.account(withId: LoginManager.shared.userId!)
        
        self.nome.text = self.account.email
        self.dataNascita.text = self.account.birthdate
        if DataStore.projectManager(with: self.account.bid) != nil {
            self.ruolo.text = "Project manager"
            self.hideUIElements()
        } else if DataStore.teamLeader(with: self.account.bid) != nil {
            self.ruolo.text = "Team Leader"
            self.hideUIElements()
        } else {
            self.ruolo.text = "Employee"
        }
    }
    
    @IBAction func chiydi(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func hideUIElements() {
        self.taskImageView.isHidden = true
        
        self.teamButton.isHidden = true
        self.achievementButton.isHidden = true
        self.tasksButton.isHidden = true
    }
    
    @IBAction func taskList(_ sender: UIButton) {
    }
    
    @IBAction func achievmentsPressed(_ sender: UIButton) {
    }
    
    @IBAction func teamSelected(_ sender: UIButton) {
    }
}

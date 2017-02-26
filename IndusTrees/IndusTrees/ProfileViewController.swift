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
    
    let account: Account? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let account = account else {
            return
        }
        
        nome.text = account.email
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func taskList(_ sender: UIButton) {
    }
    
    @IBAction func achievmentsPressed(_ sender: UIButton) {
    }
    
    @IBAction func teamSelected(_ sender: UIButton) {
    }
}

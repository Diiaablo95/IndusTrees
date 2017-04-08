//
//  TLAddMemberController.swift
//  IndusTrees
//
//  Created by Alberto Saltarelli on 26/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import UIKit

class TLAddMemberController: UIViewController {
    
    
    @IBOutlet weak var memberTableView: UITableView!
    var employees: [Employee] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.memberTableView.dataSource = self
        self.memberTableView.delegate = self
        
        self.employees = DataStore.employees.sorted { $0.bid < $1.bid }
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func chiydi(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TLAddMemberController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeePlusAddCell") as! EmployeePlusAddCell
        
        cell.imageVIew.image = self.employees[indexPath.row].account.image
        cell.labelName.text = self.employees[indexPath.row].account.name + " " + self.employees[indexPath.row].account.surname
        cell.imageToHidden.isHidden = self.employees[indexPath.row].teamLeader != nil
        
        return cell
    }
}

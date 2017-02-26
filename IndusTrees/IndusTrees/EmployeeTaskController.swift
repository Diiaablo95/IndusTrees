//
//  EmployeeTaskController.swift
//  IndusTrees
//
//  Created by Alberto Saltarelli on 26/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import UIKit

class EmployeeTaskController: UIViewController {
    
    @IBOutlet weak var taskTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.taskTableView.dataSource = self
        self.taskTableView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension EmployeeTaskController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeTaskCell") as! EmployeeTaskCell
        
        //Configure
        
        return cell
    }
}

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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.memberTableView.dataSource = self
        self.memberTableView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TLAddMemberController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCellPlusAdd") as! EmployeePlusAddCell
        
        //configure
        
        return cell
    }
}

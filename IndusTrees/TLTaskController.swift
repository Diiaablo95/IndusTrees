//
//  TLTaskController.swift
//  IndusTrees
//
//  Created by Alberto Saltarelli on 26/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import UIKit

class TLTaskController: UIViewController {

    
    @IBOutlet weak var taskTableView: UITableView!
    var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.taskTableView.dataSource = self
        self.taskTableView.delegate = self
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        // Do any additional setup after loading the view.
        
        self.tasks = DataStore.tasks.sorted { $0.0.bid < $0.1.bid }
    }
    
    @IBAction func chiydi(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension TLTaskController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tlTaskCell") as! TLTaskCell
        
        cell.taskTitle.text = self.tasks[indexPath.row].name
        cell.taskDescription.text = self.tasks[indexPath.row].description
        
        return cell
    }
}

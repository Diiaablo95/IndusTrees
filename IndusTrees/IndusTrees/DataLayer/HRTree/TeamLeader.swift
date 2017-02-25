//
//  TeamLeader.swift
//  IndusTrees
//
//  Created by Gianluca Salvato on 25/02/2017.
//  Copyright © 2017 CheeriOS. All rights reserved.
//

class TeamLeader: Employee, ManagerType {

	var team: Set<Employee> = [] /*{
		didSet { self.children = self.team.map { $0 as! Node } }
	}*/


	weak var projectManager: ProjectManager? /*{
		didSet { self.ancestor = projectManager }
	}*/

	convenience init(employee: Employee) {
		self.init(account: employee.account)
	}

	func invite(employee: Employee) {
		self.team.insert(employee)
	}
	func kick(employee: Employee) -> Employee? {
		return self.team.remove(employee)
	}

	func assign(task: Task, to employee: Employee) {
		self.delegate?.leader(willAssign: task, to: employee)
		employee.recieve(assignment: task)
		self.delegate?.leader(didAssign: task, to: employee)
	}

}

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
		self.delegate?.leader(willInvite: employee)
		self.team.insert(employee)
		self.delegate?.leader(didInvite: employee)
	}

	func kick(employee: Employee) -> Employee? {
		self.delegate?.leader(willKick: employee)
		let e = self.team.remove(employee)
		self.delegate?.leader(didKick: employee)
		return e
	}

	func assign(task: Task, to employee: Employee) {
		self.delegate?.leader(willAssign: task, to: employee)
		employee.recieve(assignment: task)
		self.delegate?.leader(didAssign: task, to: employee)
	}

	func validate(task: Task) {
		switch task.state {
			case .finished:
				self.delegate?.leader(willValidate: task)
					task.state = .validated
				self.delegate?.leader(didValidate: task)
			default: return
		}
	}

	func reassign(task: Task, to employee: Employee) {
		self.reassign(task: task, to: [employee])
	}


	func reassign(task: Task, to employees: [Employee]) {
		switch task.state {
		case .finished:
			self.delegate?.leader(willReopen: task)
			task.state = .assigned(employees)
			self.delegate?.leader(didReopen: task)
		default: return
		}
	}

}

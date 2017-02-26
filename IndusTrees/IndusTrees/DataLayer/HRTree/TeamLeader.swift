//
//  TeamLeader.swift
//  IndusTrees
//
//  Created by Gianluca Salvato on 25/02/2017.
//  Copyright © 2017 CheeriOS. All rights reserved.
//

import Foundation

class TeamLeader: Employee, TeamLeaderType {

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

	func assign(task: Task, to employee: Employee, dueOn date: Date) {
		self.delegate?.leader(willAssign: task, to: employee)
		employee.recieve(assignment: task, dueOn: date)
		self.delegate?.leader(didAssign: task, to: employee)
	}

	func validate(task: Task) {
		switch task.state {
			case .finished:
				self.delegate?.leader(willValidate: task)
					task.state = .validated(self)
				self.delegate?.leader(didValidate: task)
			default: return
		}
	}

	func reassign(task: Task, to employee: Employee, within date: Date) {
		self.reassign(task: task, to: [employee], within: date)
	}


	func reassign(task: Task, to employees: [Employee], within date: Date) {
		switch task.state {
		case .finished:
			self.delegate?.leader(willReopen: task)
			task.state = .assigned(employees, within: date)
			self.delegate?.leader(didReopen: task)
		default: return
		}
	}

}

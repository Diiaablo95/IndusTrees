//
//  Task.swift
//  IndusTrees
//
//  Created by Gianluca Salvato on 25/02/2017.
//  Copyright © 2017 CheeriOS. All rights reserved.
//

import Foundation


protocol TaskHandlerDelegate {

	func employee(didRecieve task: Task)
	func employee(willRecieve task: Task)

	func employee(willMark: Task, completed: Bool)
	func employee(didMark: Task, completed: Bool)

	func leader<T: EmployeeType>(willAssign: Task, to: T)
	func leader<T: EmployeeType>(didAssign: Task, to: T)
	
}



enum TaskState<T: EmployeeType> {
	case unassigned
	case assigned(T)
	case finished, validated
}

class Task: BeaconIndentifiable {
	var bid: UInt16
	var name: String
	var baseScore: Double
	var description: String
	var category: String?

	var employees: Set<Employee>?
	var achivements: Set<Achivement> = []

	var state: TaskState<Employee> = .unassigned

	init(id: UInt16, name: String, baseScore: Double, description: String = "") {
		self.bid = id
		self.name = name
		self.baseScore = baseScore
		self.description = description
	}

	func assign(to employee: Employee) {
		employee.tasks.insert(self)
		self.state = .assigned(employee)
	}

	func revoke(from employee: Employee) {
		employee.tasks.remove(self)
		self.state = .unassigned
	}

	var actualScore: Double? {
		switch self.state {
			case let .assigned(employee): return Double(baseScore)/Double(employee.currentExp)
			default: return nil
		}
	}

}

extension Task: Hashable {

	var hashValue: Int { return Int(self.bid) }

	static func ==(lhs: Task, rhs: Task) -> Bool {
		return lhs.hashValue == rhs.hashValue
	}

}


class TaskSet {

	var tasks: [Task] = []
	var category: String = ""


}

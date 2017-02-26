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

	func employee(willCommentOn: Task, saying: String)
	func employee(didCommentOn: Task, saying: String)

	func leader(willReopen: Task)
	func leader(didReopen: Task)

	func leader(willInvite: Employee)
	func leader(didInvite: Employee)

	func leader(willKick: Employee)
	func leader(didKick: Employee)

	func leader<T: EmployeeType>(willAssign: Task, to: T)
	func leader<T: EmployeeType>(didAssign: Task, to: T)

	func leader(willValidate: Task)
	func leader(didValidate: Task)

}



enum TaskState<T: EmployeeType> {
	case unassigned
	case assigned([T])
	case finished([T])
	case validated(T)

	var value: Int {
		switch self {
			case .unassigned: return 0
			case .assigned(_): return 1
			case .finished(_): return 2
			case .validated(_): return 3
		}
	}

	var employeeId: [UInt16]? {
		switch self {
			case let .assigned(e): return e.map{ $0.bid }
			case let .finished(e): return e.map{ $0.bid }
			default: return nil
		}
	}

	var managerId: UInt16? {
		switch self {
			case let .validated(e): return e.bid
			default: return nil
		}
	}
}

class Task: BeaconIndentifiable {
	var bid: UInt16
	var name: String
	var baseScore: Double
	var description: String
	var category: String?

	var employees: Set<Employee>?
	var achivements: Set<Achivement> = []

	var comments: [Employee: [(String, on: Date)]] = [:]

	var state: TaskState<Employee> = .unassigned {
		didSet {
			switch state {
				case .unassigned: self.employees?.forEach { $0.tasks.remove(self); $0.completedTasks.remove(self) }
				case let .assigned(e): e.forEach { $0.tasks.insert(self) }
				case .finished:	self.employees?.forEach { $0.tasks.remove(self) }
				case .validated: self.employees?.forEach { $0.completedTasks.insert(self) }
			}
		}
	}

	init(id: UInt16, name: String, baseScore: Double, description: String = "") {
		self.bid = id
		self.name = name
		self.baseScore = baseScore
		self.description = description
	}

	func assign(to employee: Employee) {
		self.state = .assigned([employee])
	}

	func assign(to employees: [Employee]) {
		self.state = .assigned(employees)
	}

	func revoke(from employee: Employee) {
		self.state = .unassigned
	}

	func actualScore(for employee: Employee) -> Double? {
		return Double(baseScore)/Double(employee.currentExp)
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

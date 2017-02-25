//
//  Employee.swift
//  IndusTrees
//
//  Created by Gianluca Salvato on 25/02/2017.
//  Copyright © 2017 CheeriOS. All rights reserved.
//



import Foundation

class Employee: /*Node,*/ EmployeeType {

	//MARK: TaskHandlerDelegate
	var delegate: TaskHandlerDelegate?

	//MARK: EmployeeType

	let account: Account
	var tasks: Set<Task> = []
	var completedTasks: Set<Task> = []

	var bid: UInt16 { return self.account.bid }

	weak var teamLeader: TeamLeader? /*{
		didSet {
			self.ancestor = teamLeader
		}
	}*/

	//MARK: Improvable

	let startLevel: Int
	var currentExp: Int64

	//MARK: Evaluatable

	var currentScore: Int64
	var achivements: Set<Achivement> = []

	//MARK: TimeTraceable

	typealias BadgeEvent = (presence: Bool, Date)

	var presenceTime: Int64 = 0
	var badgeHistory: [Employee.BadgeEvent] = []


	init(account: Account, at level: Int = 1, with score: Int64 = 0) {
		self.account = account
		self.startLevel = level
		self.currentScore = score
		self.currentExp = Employee.scoreFunction(for: level)
		self.presenceTime = 0
	}

	static func scoreFunction(for level: Int) -> Int64 {
		return 1000 * Int64(level*level)
	}

	func recieve(assignment task: Task) {
		self.delegate?.employee(willRecieve: task)
			self.tasks.insert(task)
		self.delegate?.employee(willRecieve: task)
	}

	func complete(task: Task) {
		self.delegate?.employee(willMark: task, completed: true)
			self.tasks.remove(task)
			self.completedTasks.insert(task)
		self.delegate?.employee(didMark: task, completed: true)
	}

}




extension Employee: Hashable {

	var hashValue: Int { return Int(self.account.bid) }

	static func ==(lhs: Employee, rhs: Employee) -> Bool {
		return lhs.hashValue == rhs.hashValue
	}
	
}



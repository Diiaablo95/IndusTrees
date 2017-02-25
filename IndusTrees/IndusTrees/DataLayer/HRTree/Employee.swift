//
//  Employee.swift
//  IndusTrees
//
//  Created by Gianluca Salvato on 25/02/2017.
//  Copyright © 2017 CheeriOS. All rights reserved.
//

import Foundation

protocol EmployeeType: Improvable, Evaluatable {
	var account: Account { get }
}


extension Improvable {
	mutating func train(with experience: Int) { self.currentExp += experience }
	mutating func forget(experience: Int) { self.currentExp -= experience }
}

extension Evaluatable {
	mutating func add(score: Int) { self.currentScore += score }
	mutating func subtract(score: Int) { self.currentScore -= score }
}

protocol Prizable {
	func receive(notification: Notification)
	func receive(achivement: Achivement)
}


class Employee: EmployeeType, Improvable, Evaluatable/*: Node */{
	var account: Account
	var tasks: [Task] = []

	weak var teamLeader: TeamLeader?

	var currentExp: Int64
	var currentScore: Int64

	let startLevel: Int
	var achivements: [Achivement] = []

	init(account: Account, at level: Int = 1, with score: Int64 = 0) {
		self.account = account
		self.startLevel = level
		self.currentScore = score
		self.currentExp = Employee.scoreFunction(for: level)
//		super.init(id: self.account.id)
	}

	static func scoreFunction(for level: Int) -> Int64 {
		return Int64(level) * 1000
	}

}

extension Employee: Hashable {

	var hashValue: Int { return self.account.id }

	static func ==(lhs: Employee, rhs: Employee) -> Bool {
		return lhs.hashValue == rhs.hashValue
	}
	
}

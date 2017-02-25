//
//  Employee.swift
//  IndusTrees
//
//  Created by Gianluca Salvato on 25/02/2017.
//  Copyright © 2017 CheeriOS. All rights reserved.
//

protocol TimeTraceable {
	var presenceTime: Int64 { get }
}

protocol Prizable {
	var achivements: Set<Achivement> { get set }
}

protocol EmployeeType: Improvable, Evaluatable, TimeTraceable {
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

extension Prizable {
	mutating func receive(achivement: Achivement) { self.achivements.insert(achivement) }
}







class Employee: EmployeeType, Improvable, Evaluatable/*: Node */{
	var account: Account
	var tasks: [Task] = []

	weak var teamLeader: TeamLeader?

	var currentExp: Int64
	var currentScore: Int64
	var presenceTime: Int64

	let startLevel: Int
	var achivements: [Achivement] = []

	init(account: Account, at level: Int = 1, with score: Int64 = 0) {
		self.account = account
		self.startLevel = level
		self.currentScore = score
		self.currentExp = Employee.scoreFunction(for: level)
		self.presenceTime = 0
//		super.init(id: self.account.id)
	}

	static func scoreFunction(for level: Int) -> Int64 {
		return 1000*Int64(level*level)
	}

}




extension Employee: Hashable {

	var hashValue: Int { return Int(self.account.bid) }

	static func ==(lhs: Employee, rhs: Employee) -> Bool {
		return lhs.hashValue == rhs.hashValue
	}
	
}



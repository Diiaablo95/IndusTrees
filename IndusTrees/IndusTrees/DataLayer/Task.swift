//
//  Task.swift
//  IndusTrees
//
//  Created by Gianluca Salvato on 25/02/2017.
//  Copyright © 2017 CheeriOS. All rights reserved.
//

import Foundation

enum TaskState {
	case unassigned
	case assigned(EmployeeType)
	case finished, validated
}

class Task: BeaconIndentifiable {
	var bid: UInt16
	var name: String
	var baseScore: Int
	var description: String
	var category: String?

	var employees: Set<Employee>?
	var achivements: Set<Achivement> = []

	init(id: UInt16, name: String, baseScore: Int, description: String = "") {
		self.bid = id
		self.name = name
		self.baseScore = baseScore
		self.description = description
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

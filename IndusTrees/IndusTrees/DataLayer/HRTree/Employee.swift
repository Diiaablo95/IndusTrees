//
//  Employee.swift
//  IndusTrees
//
//  Created by Gianluca Salvato on 25/02/2017.
//  Copyright © 2017 CheeriOS. All rights reserved.
//

import Foundation

class Employee: Node {
	var account: Account
	var tasks: [Task] = []

	weak var teamLeader: TeamLeader?

	init(account: Account) {
		self.account = account
	}

}



extension Employee: Hashable {

	var hashValue: Int { return self.account.id }

	static func ==(lhs: Employee, rhs: Employee) -> Bool {
		return lhs.hashValue == rhs.hashValue
	}
}

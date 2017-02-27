//
//  EmployeeProtocols.swift
//  IndusTrees
//
//  Created by Gianluca Salvato on 25/02/2017.
//  Copyright © 2017 CheeriOS. All rights reserved.
//

import Foundation

protocol Improvable {

	var currentExp: Double { get set }
	var startLevel: Int { get }

}

protocol Evaluatable {

	var currentScore: Double { get set }
	var achivements: Set<Achivement> { get }

}

protocol TimeTraceable {

	var presenceTime: Double { get }
	var badgeHistory: [(presence: Bool, Date)] { get set }

}

protocol Prizable {

	var achivements: Set<Achivement> { get set }

}

protocol EmployeeType: class, Hashable, Improvable, Evaluatable, TimeTraceable, BeaconIndentifiable {

	var account: Account { get }
	var tasks: Set<Task> { get set }
	var completedTasks: Set<Task> { get }

}


protocol TeamLeaderType: class, EmployeeType {
	var team: Set<Employee> { get set }
}

protocol ManagerType: class, TeamLeaderType {
	var teamLeaders: Set<TeamLeader> { get set }
}











extension Improvable {
	mutating func train(with experience: Double) { self.currentExp += experience }
	mutating func forget(experience: Double) { self.currentExp -= experience }
}

extension Evaluatable {
	mutating func add(score: Double) { self.currentScore += score }
	mutating func subtract(score: Double) { self.currentScore -= score }
}

extension TimeTraceable {

	mutating func badgeIn() {
		let date = Date(timeIntervalSinceNow: 0)
		self.badgeHistory.append((presence: true, date))
	}

	mutating func badgeOut() {
		let date = Date(timeIntervalSinceNow: 0)
		self.badgeHistory.append((presence: false, date))
	}
	
}

extension Prizable {
	mutating func receive(achivement: Achivement) { self.achivements.insert(achivement) }
}

extension TeamLeaderType {
	func invite(employee: Employee) {
		if let leader = self as? TeamLeader {
			employee.teamLeader = leader
		}

		self.team.insert(employee)
	}
	func kick(employee: Employee) -> Employee? {
		employee.teamLeader = nil
		return self.team.remove(employee)
	}
}

extension ManagerType {
	func invite(teamLeader: TeamLeader) { self.teamLeaders.insert(teamLeader) }
	func kick(teamLeader: TeamLeader) -> TeamLeader? { return self.teamLeaders.remove(teamLeader) }
}







//
//  Scoreboard.swift
//  IndusTrees
//
//  Created by Gianluca Salvato on 25/02/2017.
//  Copyright © 2017 CheeriOS. All rights reserved.
//

import Foundation

enum ScoreboardIndex {
	case score
	case presenceTime
}

extension ScoreboardIndex {
	func get<T: EmployeeType>(for employee: T) -> Double {
		switch self {
			case .score: return employee.currentScore
			case .presenceTime: return employee.presenceTime
		}
	}
}

class Scoreboard {

	func sortEmployees(for leader: TeamLeader, by index: ScoreboardIndex) -> [Employee] {
		return leader.team.sorted { index.get(for: $0) > index.get(for: $1) }
	}

}

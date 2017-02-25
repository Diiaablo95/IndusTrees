//
//  Scoreboard.swift
//  IndusTrees
//
//  Created by Gianluca Salvato on 25/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import Foundation

class Scoreboard {

	func sortEmployees(for leader: TeamLeader) -> [EmployeeType] {
		return leader.team.sorted { $0.currentScore > $1.currentScore }
	}

}

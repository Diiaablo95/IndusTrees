//
//  TeamLeader.swift
//  IndusTrees
//
//  Created by Gianluca Salvato on 25/02/2017.
//  Copyright © 2017 CheeriOS. All rights reserved.
//

import Foundation

class TeamLeader: Employee {

	var team: [EmployeeType] = []
	weak var projectManager: ProjectManager?

}

//
//  ProjectManager.swift
//  IndusTrees
//
//  Created by Gianluca Salvato on 25/02/2017.
//  Copyright © 2017 CheeriOS. All rights reserved.
//

class Project {

	var name: String
	weak var manager: ProjectManager!

	init(name: String, managedBy manager: ProjectManager) {
		self.name = name
		self.manager = manager
	}

}

class ProjectManager: TeamLeader, ManagerType {

	var project: Project?
	var teamLeaders: Set<TeamLeader> = []

	convenience init<T: EmployeeType>(employee: T) {
		self.init(account: employee.account)
	}

	func createProject(named name: String) -> Project? {
		return Project(name: name, managedBy: self)
	}
	
}

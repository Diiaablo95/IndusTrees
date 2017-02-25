//
//  EmployeeProtocols.swift
//  IndusTrees
//
//  Created by Gianluca Salvato on 25/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import Foundation

protocol Improvable {

	var currentExp: Int64 { get set }
	var startLevel: Int { get }

}


protocol Evaluatable {

	var currentScore: Int64 { get set }
	var achivements: [Achivement] { get }

}

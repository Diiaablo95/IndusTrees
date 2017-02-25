//
//  Achivement.swift
//  IndusTrees
//
//  Created by Gianluca Salvato on 25/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import Foundation


class AchivementStore {

	static let shared = AchivementStore()

	var achivements: [Achivement] = []

	private init() {}
}



class Achivement {

	var name: String
	var description: String

	init(name: String, description: String) {
		self.name = name
		self.description = description
	}

}

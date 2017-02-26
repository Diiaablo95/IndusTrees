//
//  Achivement.swift
//  IndusTrees
//
//  Created by Gianluca Salvato on 25/02/2017.
//  Copyright © 2017 CheeriOS. All rights reserved.
//

import Foundation

protocol BeaconIndentifiable {
	var bid: UInt16 { get }
}


class AchivementStore {

	static let shared = AchivementStore()
	private init() {}

	var achivements: [Achivement] = []

}



class Achivement: BeaconIndentifiable {

	var bid: UInt16
	var name: String
	var description: String
	var hidden: Bool = false

	init(id: UInt16, name: String, description: String) {
		self.bid = id
		self.name = name
		self.description = description
	}

}


extension Achivement: Hashable {

	var hashValue: Int { return self.name.characters.count * self.description.characters.count }

	static func ==(lhs: Achivement, rhs: Achivement) -> Bool {
		return lhs.hashValue == rhs.hashValue
	}

}



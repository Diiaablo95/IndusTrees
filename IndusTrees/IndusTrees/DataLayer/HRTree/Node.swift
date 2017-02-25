//
//  Node.swift
//  IndusTrees
//
//  Created by Gianluca Salvato on 25/02/2017.
//  Copyright © 2017 CheeriOS. All rights reserved.
//

class Node {
	var id: Int
	var ancestor: Node?
	var children: [Node] = []

	init(id: Int) {
		self.id = id
	}
}

extension Node: Hashable {

	var hashValue: Int { return self.id }

	static func ==(lhs: Node, rhs: Node) -> Bool {
		return lhs.hashValue == rhs.hashValue
	}

}

//
//  Tree.swift
//  IndusTrees
//
//  Created by Gianluca Salvato on 25/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import Foundation

class Tree {

	var rootNode: Node
	var children: Set<Node> = []

	init(root node: Node) {
		self.rootNode = node
	}

}

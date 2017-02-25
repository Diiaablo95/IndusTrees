//
//  Account.swift
//  IndusTrees
//
//  Created by Gianluca Salvato on 25/02/2017.
//  Copyright © 2017 CheeriOS. All rights reserved.
//

import Foundation

class Account {
	var id: Int
	var email: String
	private var token: String

	init?(id: Int, email: String, token: String) {
		self.id = id
		self.email = email
		self.token = token
	}
}


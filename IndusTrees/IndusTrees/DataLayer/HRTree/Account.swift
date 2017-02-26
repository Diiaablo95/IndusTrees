//
//  Account.swift
//  IndusTrees
//
//  Created by Gianluca Salvato on 25/02/2017.
//  Copyright © 2017 CheeriOS. All rights reserved.
//


class Account: BeaconIndentifiable {

	var bid: UInt16
	var email: String
	private var token: String?

	init?(id: UInt16, email: String, token: String) {
		self.bid = id
		self.email = email
		self.token = token
	}

	init?(id: UInt16, email: String) {
		self.bid = id
		self.email = email
		self.token = Account.authenticate(self)
	}

	static func authenticate(_ account: Account) -> String? {
		return "dsfhjfdgioas"
	}

}


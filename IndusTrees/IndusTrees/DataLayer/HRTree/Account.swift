//
//  Account.swift
//  IndusTrees
//
//  Created by Gianluca Salvato on 25/02/2017.
//  Copyright © 2017 CheeriOS. All rights reserved.
//

import UIKit.UIImage

class Account: BeaconIndentifiable {

	var bid: UInt16
	var email: String
	private var token: String?

	var image: UIImage?

	init(id: UInt16, email: String, token: String) {
		self.bid = id
		self.email = email
		self.token = token
	}

	init?(id: UInt16, email: String, password: String) {
		self.bid = id
		self.email = email
		self.token = Account.authenticate(self, with: password)
		if self.token == nil { return nil }
	}

	static func authenticate(_ account: Account, with password: String) -> String? {
		return "?=ajgvqsfihgsbjhasdkjsdfu"
	}

}


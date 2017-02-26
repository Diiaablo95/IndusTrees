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
	var name: String
	var surname: String
	var birthdate: String
//	var birthdate: Date
	var email: String
	private var token: String?

	var image: UIImage?

	init(id: UInt16, surname: String, name: String, birthdate: String, token: String) {
		self.bid = id
		self.surname = surname
		self.name = name
		self.birthdate = birthdate
		self.email = "\(name).\(surname)@hackhaton.org"
		self.token = token
	}

	init(id: UInt16, email: String, token: String) {
		self.bid = id
		let components = email.components(separatedBy: ".")
		self.surname = components.first ?? ""
		self.name = components[1].components(separatedBy: "@").first ?? ""
		self.email = email
		self.birthdate = DataStore.account(withEmail: self.email)!.birthdate
		self.token = token
	}

	init?(id: UInt16, email: String, password: String) {
		self.bid = id
		self.email = email
		let (surname, name) = Account.nameFrom(email: email)
		self.surname = surname
		self.name = name
		self.birthdate = DataStore.account(withEmail: self.email)!.birthdate
		self.token = Account.authenticate(self, with: password)
		if self.token == nil { return nil }
	}

	static func nameFrom(email: String) -> (surname: String, name: String) {
		let components = email.components(separatedBy: ".")
		let surname = components.first ?? ""
		let name = components[1].components(separatedBy: "@").first ?? ""

		return (surname, name)
	}

	static func authenticate(_ account: Account, with password: String) -> String? {
		return "?=xaijahvi0yoo1loolieghei0ma0mai8aPoongai2Rooy9me3Cheeshef6aehee9t"
	}

}


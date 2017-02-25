//
//  Mocks.swift
//  IndusTrees
//
//  Created by Gianluca Salvato on 25/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import Foundation

class Mocks {

	static let accounts = [
		Account(id: 0, email: "salvato.gianluca@hostname.it",	token: "?=ajgvqsfihgsbjhasdkjsdfu"),
		Account(id: 2, email: "vultaggio.andrea@hostname.it",	token: "?=pkinbhfsajcxmbvhuigkjvs"),
		Account(id: 3, email: "antonino.antonio@hostname.it",	token: "?=uvjcljbvnbwqdfjhnbsdjhb"),
		Account(id: 4, email: "saltarelli.alberto@hostname.it",	token: "?=oihkcsvdjhgijdigjvbcsvd"),
		Account(id: 5, email: "dalenasimone@hostname.it",		token: "?=fhbrjhtbmnfvkjsdhkbausg")
	]

	static let employees = [
		Employee(account: DataStore.accounts[0]!),
		Employee(account: DataStore.accounts[1]!),
		Employee(account: DataStore.accounts[2]!),
		Employee(account: DataStore.accounts[3]!),
		Employee(account: DataStore.accounts[4]!)
	]

	static let teamLeaders = [
		TeamLeader(account: DataStore.employees[0].account),
		TeamLeader(account: DataStore.employees[3].account)
	]

	static let tasks = [
		Task(id: 0, name: "Estimate project costs.", baseScore: 700),
		Task(id: 1, name: "Engage market analysis.", baseScore: 500),
		Task(id: 2, name: "Prepare use cases diagram.", baseScore: 1000),
		Task(id: 3, name: "Prepare UML class diagram.", baseScore: 1000),
	]


	static let achivements = [
		Achivement(id: 0, name: "Early delivery", description: "You delivered two days early!"),
		Achivement(id: 1, name: "You improved yourself", description: "By accomplishing this task, you learnt a new technology!"),
		Achivement(id: 2, name: "Accurate delivery", description: "You delivered at just the right time!")
	]
}

typealias DataStore = Mocks														

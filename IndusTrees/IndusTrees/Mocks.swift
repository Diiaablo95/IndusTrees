//
//  Mocks.swift
//  IndusTrees
//
//  Created by Gianluca Salvato on 25/02/2017.
//  Copyright © 2017 CherriOS. All rights reserved.
//

import Foundation

class Mocks {

	private init() {}

	static var accounts = [
		Account(id: 0, email: "salvato.gianluca@cheerios.it",	token: "?=ajgvqsfihgsbjhasdkjsdfu"),
		Account(id: 1, email: "vultaggio.andrea@cheerios.it",	token: "?=pkinbhfsajcxmbvhuigkjvs"),
		Account(id: 2, email: "antonino.antonio@cheerios.it",	token: "?=uvjcljbvnbwqdfjhnbsdjhb"),
		Account(id: 3, email: "saltarelli.alberto@cheerios.it",	token: "?=oihkcsvdjhgijdigjvbcsvd"),
		Account(id: 4, email: "dalena.simone@cheerios.it",		token: "?=fhbrjhtbmnfvkjsdhkbausg")
	]

	static var employees = [
		Employee(account: DataStore.accounts[0]),
		Employee(account: DataStore.accounts[1]),
		Employee(account: DataStore.accounts[2]),
		Employee(account: DataStore.accounts[3]),
		Employee(account: DataStore.accounts[4])
	]

	static var teamLeaders = [
		TeamLeader(employee: DataStore.employees[0]),
		TeamLeader(employee: DataStore.employees[3])
	]

	static var projectManagers = [
		ProjectManager(employee: DataStore.employees[2])
	]

	static var tasks = [
		Task(id: 0, name: "Estimate project costs.", baseScore: 700, giving: 100),
		Task(id: 1, name: "Engage market analysis.", baseScore: 500, giving: 100),
		Task(id: 2, name: "Prepare use cases diagram.", baseScore: 1000, giving: 500),
		Task(id: 3, name: "Prepare UML class diagram.", baseScore: 1000, giving: 500)
	]


	static var achivements = [
		Achivement(id: 0, name: "Early delivery", description: "You delivered two days early!"),
		Achivement(id: 1, name: "You improved yourself", description: "By accomplishing this task, you learnt a new technology!"),
		Achivement(id: 2, name: "Accurate delivery", description: "You delivered at just the right time!")
	]

}

extension Mocks {

	static func account(withEmail address: String) -> Account? {
		return DataStore.accounts.first { $0.email == address }
	}
    
    static func account(withId id: UInt16) -> Account? {
        return DataStore.accounts.first { $0.bid == id }
    }

	static func employee(with id: UInt16) -> Employee? {
		return DataStore.employees.first { $0.account.bid == id }
	}

	static func teamLeader(with id: UInt16) -> Employee? {
		return DataStore.teamLeaders.first { $0.account.bid == id }
	}

	static func projectManagers(with id: UInt16) -> Employee? {
		return DataStore.projectManagers.first { $0.account.bid == id }
	}

	static func task(with id: UInt16) -> Task? {
		return DataStore.tasks.first { $0.bid == id }
	}

	static func achivement(with id: UInt16) -> Achivement? {
		return DataStore.achivements.first { $0.bid == id }
	}

}


typealias DataStore = Mocks														

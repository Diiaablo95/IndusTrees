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

	static var accounts: Set<Account> = [
		Account(id:  0, surname: "salvato",		name: "gianluca",	birthdate: "22/06/1990", token: "?=dahlie6wu9Eelahie9iechugi9phic7eiT7aega3zi1ooL3bah5Ohse1Ohthu7Ai"),
		Account(id:  1, surname: "vultaggio",	name: "andrea",		birthdate: "30/10/1989", token: "?=ciereebai9uz1Oodoo0loh2aim8Ul1ing7xoasaghoo4ohLogh4Iejeeghah3aib"),
		Account(id:  2, surname: "antonino",	name: "antonio",	birthdate: "24/05/1995", token: "?=moong8gaigocaid1shu9ooFae4eeshae6ith9duzoFoo4ji0AV1bohqu3tha7Ohx"),
		Account(id:  3, surname: "saltarelli",	name: "alberto",	birthdate: "22/03/1993", token: "?=veoph8keer0eiqueithee1EaW7uiwahu7Jei1ahee1faaL9aicavah4ziteul1Th"),
		Account(id:  4, surname: "dalena",		name: "simone",		birthdate: "08/08/1996", token: "?=vaenu1ouwaew5Ohthae3eiGae7se1ThaiPheeje3Aethae3iaSai4veichohng9o"),

		Account(id:  5, surname: "ventriglia",	name: "federica",	birthdate: "30/03/1994", token: "?=mievahc0iavungi4PheevoopaingeiF3Jahv3chee4ipaexeing5awooNgilouph"),
		Account(id:  6, surname: "leopizzi",	name: "giacomo",	birthdate: "25/08/1996", token: "?=Shah0xihah6aip4cooroh3fi2phahph1Seechuniejeem9aigei2bee6chueleT6"),
		Account(id:  7, surname: "martorelli",	name: "simone",		birthdate: "03/08/1990", token: "?=eechoo6ziavohTheiv2xo6gaeNaetah3zoo6wieco5obaidohdoquuanee7goequ"),
		Account(id:  8, surname: "jippe",		name: "justen",		birthdate: "09/07/1994", token: "?=oa7te2ahKae7xiP5aiThangidahKeerukie2eekaisheco7puekei9vohNah9we2"),
		Account(id:  9, surname: "giulio",		name: "ingenito",	birthdate: "22/06/1996", token: "?=Ohque6vengeMohn6queeko8tier6iefooku6peehaelu3pheequai7ieN7eochee"),
		Account(id: 10, surname: "marco",		name: "capano",		birthdate: "03/11/1997", token: "?=ahyaeth4aitieshe4Xiingaequiet3ezoh3Roo3Boi6xaezohbei8phaegei4jae"),

		Account(id: 11, surname: "sibilio",		name: "davide",		birthdate: "13/08/1994", token: "?=oa5aeHohtei4gaegeecooD2zeerahng0gah9ohdixi2Lahsayie0yae1eiC8ohsa"),
		Account(id: 12, surname: "caccavale",	name: "gennaro",	birthdate: "22/07/1993", token: "?=jiejur2aephievonahqu8chootohwa3Wikah8yieNgu1faeshie5Chom6ub6aeVe"),
		Account(id: 13, surname: "schippa",		name: "pasquale",	birthdate: "26/12/1992", token: "?=achiehai9eeCah2ieveb3eo1aeriHa0nah5du5Saimee5Ve7shaecae2Aez2phae"),
		Account(id: 14, surname: "sepe",		name: "pierpaolo",	birthdate: "16/06/1994", token: "?=oozas6Eiz2dugh6ozusie8IruogaV9unootheoqu6egesaeZo6atai0choh4jiar"),

		Account(id: 15, surname: "Sacerdoti",	name: "Francesco",	birthdate: "24/03/1963", token: "rethutahshai6EenoupiN6NuebeeN8ohw0Quais4weingoh1iephocieVah6Jah7")
	]

	static var employees: Set<Employee> = Set((0..<15).map { Employee(account: Mocks.account(with: $0)!) })
	static var teamLeaders: Set<TeamLeader> = Set([0, 5, 11].map { TeamLeader(employee: DataStore.employee(with: $0)!) })
	static var projectManagers: Set<ProjectManager> = Set([ProjectManager(employee: DataStore.employee(with: 15)!)])

	static var tasks: Set<Task> = [
		Task(id:  0, name: "Define the Big Idea",					baseScore: 500,		giving: 100),
		Task(id:  1, name: "Prepare guiding questions",				baseScore: 500,		giving: 300),
		Task(id:  2, name: "Engage the question set",				baseScore: 500,		giving: 300),
		Task(id:  3, name: "Define the essential question",			baseScore: 300,		giving: 500),
		Task(id:  4, name: "Brainstorm for a solution",				baseScore: 750,		giving: 300),
		Task(id:  5, name: "Find and analyze competitors",			baseScore: 500,		giving: 500),
		Task(id:  6, name: "Refine the solution",					baseScore: 750,		giving: 500),
		Task(id:  7, name: "Evaluate risks and opportunities",		baseScore: 500,		giving: 1000),
		Task(id:  8, name: "Prepare UX personas",					baseScore: 500,		giving: 750),
		Task(id:  9, name: "Define goals and timelines",			baseScore: 500,		giving: 500),
		Task(id: 10, name: "Define essential features",				baseScore: 500,		giving: 750),
		Task(id: 11, name: "Prepare use cases",						baseScore: 750,		giving: 500),
		Task(id: 12, name: "Prepare class diagram",					baseScore: 1000,	giving: 1000),
		Task(id: 13, name: "Prepare interaction diagram",			baseScore: 1250,	giving: 1000),
		Task(id: 14, name: "Evaluate project costs",				baseScore: 500,		giving: 1000),
		Task(id: 15, name: "Define a division of labors",			baseScore: 1000,	giving: 750),
		Task(id: 16, name: "Prepare three mock-up alternatives",	baseScore: 1000,	giving: 1000),
		Task(id: 17, name: "Choose and refine one mock-up",			baseScore: 500,		giving: 1250),
		Task(id: 18, name: "Define basic API",						baseScore: 1250,	giving: 750),
		Task(id: 19, name: "Prepare server building blocks",		baseScore: 1500,	giving: 1000),
		Task(id: 20, name: "Implement server business logic",		baseScore: 2000,	giving: 1000),
		Task(id: 21, name: "Build server appliance",				baseScore: 2000,	giving: 1500),
		Task(id: 22, name: "Prepare data layer",					baseScore: 1500,	giving: 1000),
		Task(id: 23, name: "Prepare application layer",				baseScore: 1500,	giving: 1000),
		Task(id: 24, name: "Prepare presentation layer",			baseScore: 2000,	giving: 1500)
	]


	static var achivements: Set<Achivement> = [
		Achivement(id:  0, name: "Task completed",				description: "Congratulations! You just completed your first task! Wait for it to be validated by your team leader!"),
		Achivement(id:  1, name: "Early delivery",				description: "You delivered two or more days early!"),
		Achivement(id:  2, name: "You improved yourself",		description: "By accomplishing this task, you learnt a new technology!"),
		Achivement(id:  3, name: "Caregiver",					description: "You brought everyone coffee! Nice teamwork!"),
		Achivement(id:  4, name: "Animal lover",				description: "You stopped to stroke a cat."),
		Achivement(id:  5, name: "Mood softener",				description: "You managed to cheer your colleagues up in a stressful moment."),
		Achivement(id:  6, name: "100 commits",					description: "You reached 100 commits on the project repository! Nice work!"),
		Achivement(id:  7, name: "First issue",					description: "You filed an issue on our tracker! We'll have a look at it!"),
		Achivement(id:  8, name: "Nice player",					description: "You never missed a deadline date this month!"),
		Achivement(id:  9, name: "Good Samaritan",				description: "You helped two of your colleagues in their work without letting this affect the quality of your own."),

		Achivement(id: 10, name: "Checklist: check!",			description: "You completed your first checklist in our company!"),
		Achivement(id: 11, name: "Great teamwork",				description: "You and your colleagues often deliver your combined work in a short time!"),
		Achivement(id: 12, name: "Cleaner",						description: "You dropped the coffee and didn't just walk away!"),
		Achivement(id: 13, name: "Pacifier",					description: "You managed to stop your two colleagues from fighting."),
		Achivement(id: 14, name: "Conversationalist",			description: "You sure talk a lot!"),
		Achivement(id: 15, name: "Inventor",					description: "You found a nice solution to the coffee machine problem!"),
		Achivement(id: 16, name: "Observer",					description: "You noticed a flaw in our project that could have led us to disaster!"),
		Achivement(id: 17, name: "Recordkeeper",				description: "You managed to keep everything under control!"),
		Achivement(id: 18, name: "Challeger",					description: "You often challenge yuor colleagues! This behaviour positively stimulates them to work better!"),
		Achivement(id: 19, name: "Mocker",						description: "You completed your first product mock-up in our company!")
	]

}

extension Mocks {

	static var projectManager: ProjectManager {
		let manager = ProjectManager(account: DataStore.account(with: 0)!)
		manager.teamLeaders = DataStore.teamLeaders
		(0..<3).forEach { (mId: UInt16) in
			let leader = DataStore.teamLeader(with: mId)!
			switch mId {
				case 0: (0..<5).forEach { leader.invite(employee: DataStore.employee(with: $0)!) }
				case 1: (5..<11).forEach { leader.invite(employee: DataStore.employee(with: $0)!) }
				case 2: (11..<15).forEach { leader.invite(employee: DataStore.employee(with: $0)!) }
				default: break
			}
			manager.invite(teamLeader: leader)
		}

		return manager
	}

	static func account(withEmail address: String) -> Account? {
		return DataStore.accounts.first { $0.email == address }
	}
    
    static func account(withId id: UInt16) -> Account? {
        return DataStore.accounts.first { $0.bid == id }
    }

	static func account(with id: UInt16) -> Account? {
		return DataStore.accounts.first { $0.bid == id }
	}

	static func employee(with id: UInt16) -> Employee? {
		return DataStore.employees.first { $0.account.bid == id }
	}

	static func teamLeader(with id: UInt16) -> TeamLeader? {
		return DataStore.teamLeaders.first { $0.account.bid == id }
	}

	static func projectManager(with id: UInt16) -> ProjectManager? {
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

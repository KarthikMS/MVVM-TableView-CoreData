//
//  CoreDataService.swift
//  FinancePractice
//
//  Created by Karthik M S on 01/01/20.
//  Copyright © 2020 Zoho. All rights reserved.
//

import CoreData

class CoreDataService {
	static let shared = CoreDataService()

	// MARK: - Properties
	private lazy var context: NSManagedObjectContext = {
	    let container = NSPersistentContainer(name: "FinancePractice")
	    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
	        if let error = error as NSError? {
	            fatalError("Unresolved error \(error), \(error.userInfo)")
	        }
	    })
		return container.viewContext
	}()
}

// MARK: - Exposed functions
internal extension CoreDataService {
	func saveContext () {
	    if context.hasChanges {
	        do {
	            try context.save()
	        } catch {
	            let nserror = error as NSError
	            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
	        }
	    }
	}

	// del
	func addTestData() {
		let profileEntity = NSEntityDescription.entity(forEntityName: "Profile", in: context)!
		let accountEntity = NSEntityDescription.entity(forEntityName: "Account", in: context)!

		let account = Account(entity: accountEntity, insertInto: context)
		account.name = "HDFC"

		let profile = Profile(entity: profileEntity, insertInto: context)
		profile.userName = "Karthik"
		profile.addToAccounts(account)

		saveContext()
	}

	func printCoreDataContents() {
		let fetchRequest = NSFetchRequest<Profile>(entityName: "Profile")
		let profiles: [Profile]
		do {
			profiles = try context.fetch(fetchRequest)
		} catch {
			fatalError("Error fetching. \(error.localizedDescription)")
		}
		print(profiles)
	}
	// del
}

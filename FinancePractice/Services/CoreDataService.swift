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
}

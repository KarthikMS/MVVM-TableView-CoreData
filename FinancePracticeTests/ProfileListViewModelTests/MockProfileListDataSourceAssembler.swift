@testable import FinancePractice
import CoreData

class MockProfileListDataSourceAssembler {
	static func createInstance() -> ProfileListDataSource {
		let container = NSPersistentContainer(name: "FinancePractice")
		let description = NSPersistentStoreDescription()
		description.type = NSInMemoryStoreType
		container.persistentStoreDescriptions = [description]
	    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
	        if let error = error as NSError? {
	            fatalError("Unresolved error \(error), \(error.userInfo)")
	        }
	    })

		return ProfileListDataSourceCoreDataImpl(context: container.viewContext)
	}
}

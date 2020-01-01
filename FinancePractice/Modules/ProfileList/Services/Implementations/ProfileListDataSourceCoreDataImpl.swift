import CoreData

class ProfileListDataSourceCoreDataImpl: ProfileListDataSource {
	// MARK: - Dependencies
	private let coreDataService = CoreDataService.shared
	private let context: NSManagedObjectContext

	init() {
		context = coreDataService.context
	}
}

// MARK: - ProfileListDataSource
extension ProfileListDataSourceCoreDataImpl {
	func getAllProfiles() -> [Profile] {
		let fetchRequest = NSFetchRequest<Profile>(entityName: "Profile")
		fetchRequest.sortDescriptors = [NSSortDescriptor(key: "userName", ascending: true)]

		let profiles: [Profile]
		do {
			profiles = try context.fetch(fetchRequest)
		} catch {
			fatalError()
		}
		return profiles
	}

	func addProfile(userName: String) {
		let profileEntity = NSEntityDescription.entity(forEntityName: "Profile", in: context)!
		let profile = Profile(entity: profileEntity, insertInto: context)
		profile.userName = userName
		coreDataService.saveContext()
	}
}

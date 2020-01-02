import CoreData

class ProfileListDataSourceCoreDataImpl: NSObject, ProfileListDataSource {
	// MARK: - Dependencies
	private let coreDataService = CoreDataService.shared
	private let context: NSManagedObjectContext
	private let fetchedResultsController: NSFetchedResultsController<Profile>

	override init() {
		self.context = coreDataService.context

		// Setting up fetchedResultsController
		let fetchRequest = NSFetchRequest<Profile>(entityName: "Profile")
		fetchRequest.sortDescriptors = [NSSortDescriptor(key: "userName", ascending: true)]
		self.fetchedResultsController = NSFetchedResultsController<Profile>(
			fetchRequest: fetchRequest,
			managedObjectContext: context,
			sectionNameKeyPath: nil,
			cacheName: nil
		)

		super.init()

		fetchedResultsController.delegate = self
	}

	weak var observer: ProfileListDataSourceObserver?
}

// MARK: - ProfileListDataSource
extension ProfileListDataSourceCoreDataImpl {
	func fetchProfiles() -> [Profile] {
		do {
			try fetchedResultsController.performFetch()
			return fetchedResultsController.fetchedObjects ?? []
		} catch {
			fatalError()
		}
	}

	func addProfile(userName: String) {
		let profileEntity = NSEntityDescription.entity(forEntityName: "Profile", in: context)!
		let profile = Profile(entity: profileEntity, insertInto: context)
		profile.userName = userName
		coreDataService.saveContext()
	}

	func clearData() {
		for profile in getAllProfiles() {
			context.delete(profile)
		}
		coreDataService.saveContext()
	}
}

// MARK: - NSFetchedResultsControllerDelegate
extension ProfileListDataSourceCoreDataImpl: NSFetchedResultsControllerDelegate {
	func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		observer?.projectsWillChange()
	}

	func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
		switch type {
		case .insert:
			observer?.projectInserted(at: newIndexPath!)
		case .delete:
			observer?.projectDeleted(at: indexPath!)
		case .move:
			break
		case .update:
			observer?.projectUpdated(at: indexPath!)
		@unknown default:
			break
		}
	}

	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		guard let profiles = fetchedResultsController.fetchedObjects else { return }
		observer?.profilesChanged(to: profiles)
	}
}

// MARK: - Util
private extension ProfileListDataSourceCoreDataImpl {
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
}

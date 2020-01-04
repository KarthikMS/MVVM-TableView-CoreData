import CoreData

class ProfileListDataSourceCoreDataImpl: NSObject, ProfileListDataSource {
	// MARK: - Dependencies
	private let coreDataService = CoreDataService.shared
	private let context: NSManagedObjectContext

	// MARK: - Properites
	weak var observer: ProfileListDataSourceObserver?
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
}

// MARK: - ProfileListDataSource
extension ProfileListDataSourceCoreDataImpl {
	var profiles: [Profile] {
		if let fetchedProfiles = fetchedResultsController.fetchedObjects {
			return fetchedProfiles
		} else {
			return fetchProfiles()
		}
	}

	func addProfile(named userName: String) {
		let profileEntity = NSEntityDescription.entity(forEntityName: "Profile", in: context)!
		let profile = Profile(entity: profileEntity, insertInto: context)
		profile.userName = userName
		coreDataService.saveContext()
	}

	func clearData() {
		for profile in profiles {
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
	func fetchProfiles() -> [Profile] {
		do {
			try fetchedResultsController.performFetch()
			return fetchedResultsController.fetchedObjects ?? []
		} catch {
			fatalError()
		}
	}
}

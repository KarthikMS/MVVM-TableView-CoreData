import CoreData

class AccountListDataSourceCoreDataImpl: NSObject, AccountListDataSource {
	// MARK: - Dependencies
	var profile: Profile
	private let context: NSManagedObjectContext

	// MARK: - Properties
	weak var observer: AccountListDataSourceObserver?
	private let fetchedResultsController: NSFetchedResultsController<Account>

	init(profile: Profile, context: NSManagedObjectContext) {
		self.profile = profile
		self.context = context

		// Setting up fetchedResultsController
		let fetchRequest = NSFetchRequest<Account>(entityName: "Account")
		fetchRequest.predicate = NSPredicate(format: "profile == %@", profile)
		fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
		self.fetchedResultsController = NSFetchedResultsController<Account>(
			fetchRequest: fetchRequest,
			managedObjectContext: context,
			sectionNameKeyPath: nil,
			cacheName: nil
		)

		super.init()

		fetchedResultsController.delegate = self
	}
}

// MARK: - AccountListDataSource
extension AccountListDataSourceCoreDataImpl {
	var accounts: [Account] {
		if let fetchedAccounts = fetchedResultsController.fetchedObjects {
			return fetchedAccounts
		} else {
			return fetchAccounts()
		}
	}

	func addAccount(named name: String) {
		let accountEntity = NSEntityDescription.entity(forEntityName: "Account", in: context)!
		let account = Account(entity: accountEntity, insertInto: context)
		account.name = name
		account.profile = profile

		do {
			try context.save()
		} catch {
			fatalError()
		}
	}
}

// MARK: - NSFetchedResultsControllerDelegate
extension AccountListDataSourceCoreDataImpl: NSFetchedResultsControllerDelegate {
	func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		observer?.accountsWillChange()
	}

	func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
		switch type {
		case .insert:
			observer?.accountInserted(at: newIndexPath!)
		case .delete:
			observer?.accountDeleted(at: indexPath!)
		case .move:
			break
		case .update:
			observer?.accountUpdated(at: indexPath!)
		@unknown default:
			break
		}
	}

	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		guard let accounts = fetchedResultsController.fetchedObjects else { return }
		observer?.accountsChanged(to: accounts)
	}
}

// MARK: - Util
private extension AccountListDataSourceCoreDataImpl {
	func fetchAccounts() -> [Account] {
		do {
			try fetchedResultsController.performFetch()
			return fetchedResultsController.fetchedObjects ?? []
		} catch {
			fatalError()
		}
	}
}

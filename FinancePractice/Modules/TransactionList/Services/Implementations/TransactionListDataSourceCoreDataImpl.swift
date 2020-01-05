import CoreData

class TransactionListDataSourceCoreDataImpl: NSObject, TransactionListDataSource {
	// MARK: - Dependencies
	var account: Account
	private let context: NSManagedObjectContext

	// MARK: - Properties
	weak var observer: TransactionListDataSourceObserver?
	private let fetchedResultsController: NSFetchedResultsController<Transaction>

	init(account: Account, context: NSManagedObjectContext) {
		self.account = account
		self.context = context

		// Setting up fetchedResultsController
		let fetchRequest = NSFetchRequest<Transaction>(entityName: "Transaction")
		fetchRequest.predicate = NSPredicate(format: "account == %@", account)
		fetchRequest.sortDescriptors = [NSSortDescriptor(key: "amount", ascending: true)]
		self.fetchedResultsController = NSFetchedResultsController<Transaction>(
			fetchRequest: fetchRequest,
			managedObjectContext: context,
			sectionNameKeyPath: nil,
			cacheName: nil
		)

		super.init()

		fetchedResultsController.delegate = self
	}
}

// MARK: - TransactionListDataSource
extension TransactionListDataSourceCoreDataImpl {
	var transactions: [Transaction] {
		if let fetchedTransactions = fetchedResultsController.fetchedObjects {
			return fetchedTransactions
		} else {
			return fetchTransactions()
		}
	}

	func addTransaction(amount: Float, note: String?, placeName: String?) {
		let transactionEntity = NSEntityDescription.entity(forEntityName: "Transaction", in: context)!
		let transaction = Transaction(entity: transactionEntity, insertInto: context)

		transaction.amount = amount
		transaction.note = note
		transaction.account = account
		transaction.createdAt = Date()

		if let placeName = placeName,
			placeName != "" {
			transaction.place = getPlace(named: placeName)
		}

		do {
			try context.save()
		} catch {
			fatalError()
		}
	}

	func toggleSort() {
		let currentSortType = fetchedResultsController.fetchRequest.sortDescriptors![0].key!
		let newSortType: String
		if currentSortType == "amount" {
			newSortType = "createdAt"
		} else {
			newSortType = "amount"
		}
		fetchedResultsController.fetchRequest.sortDescriptors = [NSSortDescriptor(key: newSortType, ascending: true)]
		do {
			try fetchedResultsController.performFetch()
		} catch {
			fatalError()
		}
	}
}

// MARK: - NSFetchedResultsControllerDelegate
extension TransactionListDataSourceCoreDataImpl: NSFetchedResultsControllerDelegate {
	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		guard let transactions = fetchedResultsController.fetchedObjects else { return }
		observer?.transactionsChanged(to: transactions)
	}
}

// MARK: - Util
private extension TransactionListDataSourceCoreDataImpl {
	func fetchTransactions() -> [Transaction] {
		do {
			try fetchedResultsController.performFetch()
			return fetchedResultsController.fetchedObjects ?? []
		} catch {
			fatalError()
		}
	}

	func getPlace(named placeName: String) -> Place {
		// Checking if place already exists
		let placeFetchRequest = NSFetchRequest<Place>(entityName: "Place")
		placeFetchRequest.predicate = NSPredicate(format: "name == %@", placeName)
		let existingPlace: Place?
		do {
			existingPlace = try context.fetch(placeFetchRequest).first
		} catch {
			fatalError()
		}
		if let place = existingPlace {
			return place
		}

		// Adding new place
		let placeEntity = NSEntityDescription.entity(forEntityName: "Place", in: context)!
		let newPlace = Place(entity: placeEntity, insertInto: context)
		newPlace.name = placeName
		return newPlace
	}
}

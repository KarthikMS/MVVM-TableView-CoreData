import Foundation

protocol AccountListDataSourceObserver: class {
	func accountsWillChange()
	func accountInserted(at newIndexPath: IndexPath)
	func accountDeleted(at indexPath: IndexPath)
	func accountUpdated(at indexPath: IndexPath)
	func accountsChanged(to newAccounts: [Account])
}

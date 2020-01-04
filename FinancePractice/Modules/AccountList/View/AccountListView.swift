import Foundation

protocol AccountListView: class {
	func setNavigationBarTitle(to title: String)

	// TableView
	func tableViewReload()
	func tableViewBeginUpdates()
	func tableViewInsertRow(at newIndexPath: IndexPath)
	func tableViewDeleteRow(at indexPath: IndexPath)
	func tableViewUpdateRow(at indexPath: IndexPath)
	func tableViewEndUpdates()

	func showTransactions(of account: Account)
}

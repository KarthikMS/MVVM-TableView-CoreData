import Foundation

protocol ProfileListView: class {
	// TableView
	func tableViewReload()
	func tableViewBeginUpdates()
	func tableViewInsertRow(at newIndexPath: IndexPath)
	func tableViewDeleteRow(at indexPath: IndexPath)
	func tableViewUpdateRow(at indexPath: IndexPath)
	func tableViewEndUpdates()

	func showAlertToAddProfile()
	func showListing(of profile: Profile)
}

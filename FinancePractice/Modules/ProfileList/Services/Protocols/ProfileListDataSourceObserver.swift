import Foundation

protocol ProfileListDataSourceObserver: class {
	func projectsWillChange()
	func projectInserted(at newIndexPath: IndexPath)
	func projectDeleted(at indexPath: IndexPath)
	func projectUpdated(at indexPath: IndexPath)
	func profilesChanged(to newProfiles: [Profile])
}

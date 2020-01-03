import Foundation

class ProfileListViewModel {
	// MARK: - Dependencies
	private weak var view: ProfileListView?
	private var dataSource: ProfileListDataSource

	// MARK: - Properties
	var tableViewItems = [String]()

	init(view: ProfileListView, dataSource: ProfileListDataSource) {
		self.view = view
		self.dataSource = dataSource
		self.dataSource.observer = self

		tableViewItems = dataSource.fetchProfiles().map { $0.tableViewText }
	}
}

// MARK: - Exposed functions
internal extension ProfileListViewModel {
	func viewWillAppear() {
		view?.tableViewReload()
	}

	func addProfileButtonPressed() {
		view?.showAlertToAddProfile()
	}

	func addProfile(userName: String) {
		dataSource.addProfile(userName: userName)
	}

	func clearData() {
		dataSource.clearData()
	}
}

// MARK: - ProfileListDataSourceObserver
extension ProfileListViewModel: ProfileListDataSourceObserver {
	func projectsWillChange() {
		view?.tableViewBeginUpdates()
	}

	func projectInserted(at newIndexPath: IndexPath) {
		view?.tableViewInsertRow(at: newIndexPath)
	}

	func projectDeleted(at indexPath: IndexPath) {
		view?.tableViewDeleteRow(at: indexPath)
	}

	func projectUpdated(at indexPath: IndexPath) {
		view?.tableViewUpdateRow(at: indexPath)
	}

	func profilesChanged(to newProfiles: [Profile]) {
		tableViewItems = newProfiles.map { $0.tableViewText }
		view?.tableViewEndUpdates()
	}
}

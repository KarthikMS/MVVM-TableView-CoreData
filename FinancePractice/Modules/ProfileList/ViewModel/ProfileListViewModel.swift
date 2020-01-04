import Foundation

class ProfileListViewModel {
	// MARK: - Dependencies
	weak var view: ProfileListView?
	private var dataSource: ProfileListDataSource

	// MARK: - Properties
	var tableViewItems = [String]()

	init(dataSource: ProfileListDataSource) {
		self.dataSource = dataSource
		self.dataSource.observer = self

		tableViewItems = dataSource.profiles.map { $0.tableViewCellText }
	}
}

// MARK: - Exposed functions
internal extension ProfileListViewModel {
	func viewWillAppear(view: ProfileListView) {
		self.view = view
		view.tableViewReload()
	}

	func viewWillDisappear() {
		self.view = nil
	}

	func addProfile(named userName: String) {
		dataSource.addProfile(named: userName)
	}

	func clearData() {
		dataSource.clearData()
	}

	func tableViewDidSelectRow(at indexPath: IndexPath) {
		let profiles = dataSource.profiles
		guard indexPath.row < profiles.count else { fatalError() }
		view?.showAccounts(of: profiles[indexPath.row])
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
		tableViewItems = newProfiles.map { $0.tableViewCellText }
		view?.tableViewEndUpdates()
	}
}

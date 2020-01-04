import Foundation

class AccountListViewModel {
	// MARK: - Dependencies
	private let profile: Profile
	private var dataSource: AccountListDataSource

	// MARK: - Properties
	var tableViewItems = [String]()
	weak var view: AccountListView?

	init(profile: Profile, dataSource: AccountListDataSource) {
		self.profile = profile
		self.dataSource = dataSource
		self.dataSource.observer = self

		tableViewItems = dataSource.accounts.map { $0.tableViewCellText }
	}
}

// MARK: - Exposed functions
internal extension AccountListViewModel {
	func viewDidLoad(view: AccountListView) {
		self.view = view
		view.setNavigationBarTitle(to: profile.userName)
	}

	func viewWillAppear(view: AccountListView) {
		self.view = view
		view.tableViewReload()
	}

	func viewWillDisappear() {
		self.view = nil
	}

	func addAccount(named name: String) {
		dataSource.addAccount(named: name)
	}

	func tableViewDidSelectRow(at indexPath: IndexPath) {
		let accounts = dataSource.accounts
		guard indexPath.row < accounts.count else { fatalError() }
		view?.showTransactions(of: accounts[indexPath.row])
	}
}

// MARK: - AccountListDataSourceObserver
extension AccountListViewModel: AccountListDataSourceObserver {
	func accountsWillChange() {
		view?.tableViewBeginUpdates()
	}

	func accountInserted(at newIndexPath: IndexPath) {
		view?.tableViewInsertRow(at: newIndexPath)
	}

	func accountDeleted(at indexPath: IndexPath) {
		view?.tableViewDeleteRow(at: indexPath)
	}

	func accountUpdated(at indexPath: IndexPath) {
		view?.tableViewUpdateRow(at: indexPath)
	}

	func accountsChanged(to newAccounts: [Account]) {
		tableViewItems = newAccounts.map { $0.tableViewCellText }
		view?.tableViewEndUpdates()
	}
}

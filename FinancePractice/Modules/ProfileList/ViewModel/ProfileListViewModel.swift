class ProfileListViewModel {
	// MARK: - Dependencies
	private weak var view: ProfileListView?
	private let dataSource: ProfileListDataSource

	// MARK: - Properties
	var tableViewItems = [String]()

	init(view: ProfileListView, dataSource: ProfileListDataSource) {
		self.view = view
		self.dataSource = dataSource

		tableViewItems = dataSource.getAllProfiles().map { $0.userName }
	}
}

// MARK: - Exposed functions
internal extension ProfileListViewModel {
	func addProfileButtonPressed() {
		view?.showAlertToAddProfile()
	}

	func addProfile(userName: String) {
		print("Adding \(userName)")
	}
}

class ProfileListViewModel {
	// MARK: - Dependencies
	private let dataSource: ProfileListDataSource

	// MARK: - Properties
	let tableViewItems = [String]()

	init(dataSource: ProfileListDataSource) {
		self.dataSource = dataSource
	}
}

// MARK: - Exposed functions
internal extension ProfileListViewModel {
	func addProfileButtonPressed() {
	}
}

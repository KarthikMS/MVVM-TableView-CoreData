class ProfileListViewModelAssembler {
	static func createInstance(view: ProfileListView) -> ProfileListViewModel {
		let dataSource = ProfileListDataSourceAssembler.createInstance()

		return ProfileListViewModel(
			view: view,
			dataSource: dataSource
		)
	}
}

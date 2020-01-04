class ProfileListViewModelAssembler {
	static func createInstance() -> ProfileListViewModel {
		let dataSource = ProfileListDataSourceAssembler.createInstance()
		return ProfileListViewModel(dataSource: dataSource)
	}
}

class AccountListViewModelAssembler {
	static func createInstance(profile: Profile) -> AccountListViewModel {
		let dataSource: AccountListDataSource = AccountListDataSourceCoreDataImpl(
			profile: profile,
			context: CoreDataService.shared.context
		)

		return AccountListViewModel(
			profile: profile,
			dataSource: dataSource
		)
	}
}

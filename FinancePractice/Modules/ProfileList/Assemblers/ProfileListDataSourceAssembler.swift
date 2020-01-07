class ProfileListDataSourceAssembler {
	static func createInstance() -> ProfileListDataSource {
		ProfileListDataSourceCoreDataImpl(context: CoreDataService.shared.context)
	}
}

protocol ProfileListDataSource {
	var observer: ProfileListDataSourceObserver? { get set }

	func fetchProfiles() -> [Profile]
	func addProfile(userName: String)
	func clearData()
}

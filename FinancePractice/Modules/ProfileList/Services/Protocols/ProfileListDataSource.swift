protocol ProfileListDataSource {
	var profiles: [Profile] { get }
	var observer: ProfileListDataSourceObserver? { get set }

	func addProfile(named userName: String)
	func clearData()
}

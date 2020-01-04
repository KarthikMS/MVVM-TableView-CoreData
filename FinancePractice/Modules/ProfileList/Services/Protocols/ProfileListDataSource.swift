protocol ProfileListDataSource {
	var profiles: [Profile] { get }
	var observer: ProfileListDataSourceObserver? { get set }

	func addProfile(userName: String)
	func clearData()
}

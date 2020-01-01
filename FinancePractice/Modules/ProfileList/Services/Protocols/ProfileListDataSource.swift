protocol ProfileListDataSource {
	func getAllProfiles() -> [Profile]
	func addProfile(userName: String)
}

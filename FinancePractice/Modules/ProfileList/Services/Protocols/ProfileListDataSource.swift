protocol ProfileListDataSource {
	func getAllProfiles() -> [Profile]
	func add(_ profile: Profile)
}

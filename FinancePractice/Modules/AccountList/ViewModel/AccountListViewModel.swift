class AccountListViewModel {
	// MARK: - Dependencies
	private let profile: Profile

	// MARK: - Properties
	let navigationBarTitle: String

	init(profile: Profile) {
		self.profile = profile
		self.navigationBarTitle = profile.userName
	}
}

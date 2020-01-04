class AccountListViewModelAssembler {
	static func createInstance(profile: Profile) -> AccountListViewModel {
		return AccountListViewModel(profile: profile)
	}
}

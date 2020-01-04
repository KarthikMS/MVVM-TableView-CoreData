protocol AccountListDataSource {
	var profile: Profile { get set }
	var accounts: [Account] { get }
	var observer: AccountListDataSourceObserver? { get set }

	func addAccount(named name: String)
}

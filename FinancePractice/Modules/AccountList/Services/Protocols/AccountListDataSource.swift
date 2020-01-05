protocol AccountListDataSource: class {
	var profile: Profile { get }
	var accounts: [Account] { get }
	var observer: AccountListDataSourceObserver? { get set }

	func addAccount(named name: String)
}

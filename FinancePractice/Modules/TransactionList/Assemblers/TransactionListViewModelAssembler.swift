class TransactionListViewModelAssembler {
	static func createInstance(account: Account) -> TransactionListViewModel {
		let dataSource: TransactionListDataSource = TransactionListDataSourceCoreDataImpl(
			account: account,
			context: CoreDataService.shared.context
		)

		return TransactionListViewModel(
			account: account,
			dataSource: dataSource
		)
	}
}

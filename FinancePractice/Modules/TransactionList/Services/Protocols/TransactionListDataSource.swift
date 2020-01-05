protocol TransactionListDataSource: class {
	var account: Account { get }
	var transactions: [Transaction] { get }
	var observer:  TransactionListDataSourceObserver? { get set }

	func addTransaction(amount: Float, note: String?, placeName: String?)
	func toggleSort()
}

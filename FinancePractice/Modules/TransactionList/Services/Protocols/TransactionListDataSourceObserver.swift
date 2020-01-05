protocol TransactionListDataSourceObserver: class {
	func transactionsChanged(to newTransactions: [Transaction])
}

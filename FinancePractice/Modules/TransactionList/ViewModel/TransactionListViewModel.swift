import Foundation

class TransactionListViewModel {
	// MARK: - Dependencies
	private let account: Account
	private let dataSource: TransactionListDataSource

	// MARK: - Properties
	weak var view: TransactionListView?
	private var state: TransactionListViewState {
		didSet {
			view?.render(state)
		}
	}

	init(account: Account, dataSource: TransactionListDataSource) {
		self.account = account
		self.dataSource = dataSource

		let transactions = dataSource.transactions
		let navBarTitle = TransactionListViewModel.getNavBarTitle(accountName: account.name, transactions: transactions)
		let tableViewCellStates = TransactionListViewModel.getTableViewCellStates(from: transactions)
		state = TransactionListViewState(
			navBarTitle: navBarTitle,
			tableViewCellStates: tableViewCellStates
		)

		dataSource.observer = self
	}
}

// MARK: - Exposed functions
internal extension TransactionListViewModel {
	func viewDidLoad(view: TransactionListView) {
		self.view = view
		view.render(state)
	}

	func addTransaction(amount: Float, note: String?, placeName: String?) {
		dataSource.addTransaction(amount: amount, note: note, placeName: placeName)
	}

	func tableViewDidSelectRow(at indexPath: IndexPath) {
	}
}

// MARK: - TransactionListDataSourceObserver
extension TransactionListViewModel: TransactionListDataSourceObserver {
	func transactionsChanged(to newTransactions: [Transaction]) {
		let navBarTitle = TransactionListViewModel.getNavBarTitle(accountName: account.name, transactions: newTransactions)
		let tableViewCellStates = TransactionListViewModel.getTableViewCellStates(from: newTransactions)
		state = TransactionListViewState(
			navBarTitle: navBarTitle,
			tableViewCellStates: tableViewCellStates
		)
	}
}

// MARK: - Util
private extension TransactionListViewModel {
	static func getNavBarTitle(accountName: String, transactions: [Transaction]) -> String {
		"\(accountName) (\(transactions.count))"
	}

	static func getTableViewCellStates(from transactions: [Transaction]) -> [TransactionListTableViewCellState] {
		transactions
			.map { transaction -> TransactionListTableViewCellState in
				var textLabelText = "Rs.\(transaction.amount)"
				if let place = transaction.place {
					textLabelText += "@ \(place.name)"
				}

				var detailTextLabelText = ""
				if let note = transaction.note {
					detailTextLabelText = note
				}

				return TransactionListTableViewCellState(
					textLabelText: textLabelText,
					detailTextLabelText: detailTextLabelText
				)
		}
	}
}

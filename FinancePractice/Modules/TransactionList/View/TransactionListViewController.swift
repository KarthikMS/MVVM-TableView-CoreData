import UIKit
import DifferenceKit

class TransactionListViewController: UIViewController, TransactionListView {
	// MARK: - IBOutlets
	@IBOutlet weak var tableView: UITableView!
	
	// MARK: - Dependencies
	var viewModel: TransactionListViewModel!

	// MARK: - Properties
	private var currentState: TransactionListViewState!
}

// MARK: - View Life Cycle
extension TransactionListViewController {
	override func viewDidLoad() {
        super.viewDidLoad()
		viewModel.viewDidLoad(view: self)
    }
}

// MARK: - UITableViewDataSource
extension TransactionListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		currentState.tableViewCellStates.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCellIdentifier", for: indexPath)
		let cellState = currentState.tableViewCellStates[indexPath.row]
		cell.textLabel?.text = cellState.textLabelText
		cell.detailTextLabel?.text = cellState.detailTextLabelText
		return cell
	}
}

// MARK: - UITableViewDelegate
extension TransactionListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		viewModel.tableViewDidSelectRow(at: indexPath)
	}
}

// MARK: - TransactionListView
extension TransactionListViewController {
	func render(_ state: TransactionListViewState) {
		title = state.navBarTitle

		if currentState == nil {
			currentState = state
			tableView.reloadData()
			return
		}

		let changeset = StagedChangeset(source: currentState.tableViewCellStates, target: state.tableViewCellStates)
		tableView.reload(using: changeset, with: .automatic) { _ in
			currentState = state
		}
	}
}

// MARK: - IBActions
private extension TransactionListViewController {
	@IBAction func addTransactionButtonPressed(_ sender: Any) {
		showAlertToAddTransaction()
	}

	@IBAction func toggleSortButtonPressed(_ sender: Any) {
		viewModel.toggleSortButtonPressed()
	}
}

// MARK: - Alerts
private extension TransactionListViewController {
	func showAlertToAddTransaction() {
		let alertController = UIAlertController(title: "New Transaction", message: nil, preferredStyle: .alert)
		alertController.addTextField { transactionAmountTextField in
			transactionAmountTextField.placeholder = "0"
		}
		alertController.addTextField { noteTextField in
			noteTextField.placeholder = "Note"
		}
		alertController.addTextField { placeNameTextField in
			placeNameTextField.placeholder = "Place name"
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
		let addAccountAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
			let textFields = alertController.textFields!
			let transactionAmountText = textFields[0].text!
			guard let transactionAmount = Float(transactionAmountText) else { return }
			let note = textFields[1].text
			let placeName = textFields[2].text
			self?.viewModel.addTransaction(amount: transactionAmount, note: note, placeName: placeName)
		}
		alertController.addAction(cancelAction)
		alertController.addAction(addAccountAction)

		present(alertController, animated: true, completion: nil)
	}
}

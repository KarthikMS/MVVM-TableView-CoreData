import UIKit

class AccountListViewController: UIViewController, AccountListView {
	// MARK: - IBOutlets
	@IBOutlet private weak var tableView: UITableView!
	
	// MARK: - Dependencies
	var viewModel: AccountListViewModel!
}

// MARK: - View Life Cycle
extension AccountListViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.viewDidLoad(view: self)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		viewModel.viewWillAppear(view: self)
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		viewModel.viewWillDisappear()
	}
}

// MARK: - Navigation
extension AccountListViewController {
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let segueIdentifier = segue.identifier else { fatalError() }
		switch segueIdentifier {
		case "AccountListToTransactionList":
			guard let transactionListViewController = segue.destination as? TransactionListViewController,
				let account = sender as? Account else { fatalError() }
			let transactionListViewModel = TransactionListViewModelAssembler.createInstance(account: account)
			transactionListViewController.viewModel = transactionListViewModel
		default:
			break
		}
	}
}

// MARK: - UITableViewDataSource
extension AccountListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.tableViewItems.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCellIdentifier", for: indexPath)
		cell.textLabel?.text = viewModel.tableViewItems[indexPath.row]
		return cell
	}
}

// MARK: - UITableViewDelegate
extension AccountListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		viewModel.tableViewDidSelectRow(at: indexPath)
	}
}

// MARK: - AccountListView
extension AccountListViewController {
	func setNavigationBarTitle(to title: String) {
		self.title = title
	}

	func tableViewReload() {
		tableView.reloadData()
	}

	func tableViewBeginUpdates() {
		tableView.beginUpdates()
	}

	func tableViewInsertRow(at newIndexPath: IndexPath) {
		tableView.insertRows(at: [newIndexPath], with: .bottom)
	}

	func tableViewDeleteRow(at indexPath: IndexPath) {
		tableView.deleteRows(at: [indexPath], with: .top)
	}

	func tableViewUpdateRow(at indexPath: IndexPath) {
		tableView.reloadRows(at: [indexPath], with: .fade)
	}

	func tableViewEndUpdates() {
		tableView.endUpdates()
	}

	func showTransactions(of account: Account) {
		performSegue(withIdentifier: "AccountListToTransactionList", sender: account)
	}
}

// MARK: - IBActions
private extension AccountListViewController {
	@IBAction func addAccountButtonPressed(_ sender: Any) {
		showAlertToAddAccount()
	}
}

// MARK: - Alerts
private extension AccountListViewController {
	func showAlertToAddAccount() {
		let alertController = UIAlertController(title: "New Account", message: nil, preferredStyle: .alert)
		alertController.addTextField { userNameTextField in
			userNameTextField.placeholder = "Account name"
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
		let addAccountAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
			let accountName = alertController.textFields!.first!.text!
			guard !accountName.isEmpty else { return }
			self?.viewModel.addAccount(named: accountName)
		}
		alertController.addAction(cancelAction)
		alertController.addAction(addAccountAction)

		present(alertController, animated: true, completion: nil)
	}
}

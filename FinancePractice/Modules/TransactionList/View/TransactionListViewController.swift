import UIKit

class TransactionListViewController: UIViewController {
	// MARK: - IBOutlets
	@IBOutlet weak var tableView: UITableView!
	
	// MARK: - Dependencies
	var viewModel: TransactionListViewModel!
}

// MARK: - View Life Cycle
extension TransactionListViewController {
	override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - UITableViewDataSource
extension TransactionListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		1
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCellIdentifier", for: indexPath)
		cell.textLabel?.text = "dsgfsdg"
		return cell
	}
}

// MARK: - IBActions
private extension TransactionListViewController {
	@IBAction func addTransactionButtonPressed(_ sender: Any) {
	}
}

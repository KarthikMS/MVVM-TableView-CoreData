import UIKit

class AccountListViewController: UIViewController {
	// MARK: - IBOutlets
	@IBOutlet weak var tableView: UITableView!
	
	// MARK: - Dependencies
	var viewModel: AccountListViewModel!
}

// MARK: - View Life Cycle
extension AccountListViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		title = viewModel.navigationBarTitle
	}
}

// MARK: - UITableViewDataSource
extension AccountListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCellIdentifier", for: indexPath)
		cell.textLabel?.text = "dfdfd"
		return cell
	}
}

// MARK: - IBActions
private extension AccountListViewController {
	@IBAction func addAccountButtonPressed(_ sender: Any) {
	}
}

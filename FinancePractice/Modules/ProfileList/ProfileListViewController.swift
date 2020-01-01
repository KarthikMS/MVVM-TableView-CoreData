import UIKit

class ProfileListViewController: UIViewController {
	// MARK: - IBOutlets
	@IBOutlet weak var tableView: UITableView!

	// MARK: - Dependencies
	private let viewModel = ProfileListViewModelAssembler.createInstance()
}

//// MARK: - View Life Cycle
//extension ProfileListViewController {
//	override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//}

// MARK: - IBActions
private extension ProfileListViewController {
	@IBAction func addProfileButtonPressed(_ sender: Any) {
		viewModel.addProfileButtonPressed()
	}
}

// MARK: - UITableViewDataSource
extension ProfileListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.tableViewItems.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCellIdentifier", for: indexPath)
		cell.textLabel?.text = viewModel.tableViewItems[indexPath.row]
		return cell
	}
}

import UIKit

class ProfileListViewController: UIViewController, ProfileListView {
	// MARK: - IBOutlets
	@IBOutlet weak var tableView: UITableView!

	// MARK: - Dependencies
	private var viewModel: ProfileListViewModel!
}

// MARK: - View Life Cycle
extension ProfileListViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel = ProfileListViewModelAssembler.createInstance(view: self)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		viewModel.viewWillAppear()
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

// MARK: - ProfileListView
extension ProfileListViewController {
	// TableView
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

	func showAlertToAddProfile() {
		let alertController = UIAlertController(title: "New Profile", message: nil, preferredStyle: .alert)
		alertController.addTextField { userNameTextField in
			userNameTextField.placeholder = "User name"
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
		let addProfileAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
			let userName = alertController.textFields!.first!.text!
			guard !userName.isEmpty else { return }
			self?.viewModel.addProfile(userName: userName)
		}
		alertController.addAction(cancelAction)
		alertController.addAction(addProfileAction)

		present(alertController, animated: true, completion: nil)
	}
}

// MARK: - IBActions
private extension ProfileListViewController {
	@IBAction func addProfileButtonPressed(_ sender: Any) {
		viewModel.addProfileButtonPressed()
	}

	@IBAction func clearButtonPressed(_ sender: Any) {
		viewModel.clearData()
	}
}

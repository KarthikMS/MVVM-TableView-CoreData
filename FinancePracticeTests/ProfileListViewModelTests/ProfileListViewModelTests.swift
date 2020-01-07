@testable import FinancePractice
import XCTest

class ProfileListViewModelTests: XCTestCase {
	var viewModel = MockProfileListViewModelAssembler.createInstance()
	var view: ProfileListView = MockProfileListView()

    override func setUp() {
		viewModel = MockProfileListViewModelAssembler.createInstance()
		view = MockProfileListView()
		viewModel.view = view
    }

	func testIfReloadTableViewIsCalledOnViewWillAppear() {
		
	}
}

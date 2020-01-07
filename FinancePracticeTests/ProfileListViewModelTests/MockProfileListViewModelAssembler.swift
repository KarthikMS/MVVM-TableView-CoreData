@testable import FinancePractice

class MockProfileListViewModelAssembler {
	static func createInstance() -> ProfileListViewModel {
		let mockDataSource = MockProfileListDataSourceAssembler.createInstance()
		return ProfileListViewModel(dataSource: mockDataSource)
	}
}

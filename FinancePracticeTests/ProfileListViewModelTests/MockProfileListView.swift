@testable import FinancePractice
import Foundation

class MockProfileListView: ProfileListView {
	var tableViewReloadCount = 0
	var tableViewBeginUpdatesCount = 0
	var tableViewInsertRowCount = 0
	var tableViewDeleteRowCount = 0
	var tableViewUpdateRowCount = 0
	var tableViewEndUpdatesCount = 0
	var showAccountsCount = 0

	func tableViewReload() {
		tableViewReloadCount += 1
	}

	func tableViewBeginUpdates() {
		tableViewBeginUpdatesCount += 1
	}

	func tableViewInsertRow(at newIndexPath: IndexPath) {
		tableViewInsertRowCount += 1
	}

	func tableViewDeleteRow(at indexPath: IndexPath) {
		tableViewDeleteRowCount += 1
	}

	func tableViewUpdateRow(at indexPath: IndexPath) {
		tableViewUpdateRowCount += 1
	}

	func tableViewEndUpdates() {
		tableViewEndUpdatesCount += 1
	}

	func showAccounts(of profile: Profile) {
		showAccountsCount += 1
	}
}

import Foundation
import CoreData

@objc(Account)
public class Account: NSManagedObject {

}

// MARK: - Util
extension Account {
	var tableViewCellText: String {
		"\(name) (\(transactions.count))"
	}
}

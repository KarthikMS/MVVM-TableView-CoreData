import Foundation
import CoreData

@objc(Profile)
public class Profile: NSManagedObject {

}

// MARK: - Util
extension Profile {
	var tableViewCellText: String {
		"\(userName) (\(accounts.count))"
	}
}

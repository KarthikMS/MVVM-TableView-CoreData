import Foundation
import CoreData

@objc(Profile)
public class Profile: NSManagedObject {

}

extension Profile {
	var tableViewText: String {
		"\(userName) (\(accounts.count))"
	}
}

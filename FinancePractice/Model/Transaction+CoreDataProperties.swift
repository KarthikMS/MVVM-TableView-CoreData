import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var amount: Float
    @NSManaged public var note: String?
    @NSManaged public var account: Account
    @NSManaged public var place: Place?

}

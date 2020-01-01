import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var userName: String
    @NSManaged public var accounts: NSSet
    @NSManaged public var places: NSSet

}

// MARK: Generated accessors for accounts
extension Profile {

    @objc(addAccountsObject:)
    @NSManaged public func addToAccounts(_ value: Account)

    @objc(removeAccountsObject:)
    @NSManaged public func removeFromAccounts(_ value: Account)

    @objc(addAccounts:)
    @NSManaged public func addToAccounts(_ values: NSSet)

    @objc(removeAccounts:)
    @NSManaged public func removeFromAccounts(_ values: NSSet)

}

// MARK: Generated accessors for places
extension Profile {

    @objc(addPlacesObject:)
    @NSManaged public func addToPlaces(_ value: Place)

    @objc(removePlacesObject:)
    @NSManaged public func removeFromPlaces(_ value: Place)

    @objc(addPlaces:)
    @NSManaged public func addToPlaces(_ values: NSSet)

    @objc(removePlaces:)
    @NSManaged public func removeFromPlaces(_ values: NSSet)

}

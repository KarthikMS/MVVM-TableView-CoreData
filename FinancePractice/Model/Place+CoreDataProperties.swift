//
//  Place+CoreDataProperties.swift
//  FinancePractice
//
//  Created by Karthik M S on 01/01/20.
//  Copyright © 2020 Zoho. All rights reserved.
//
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var name: String
    @NSManaged public var profile: Profile
    @NSManaged public var transactions: NSSet

}

// MARK: Generated accessors for transactions
extension Place {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: Transaction)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: Transaction)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}

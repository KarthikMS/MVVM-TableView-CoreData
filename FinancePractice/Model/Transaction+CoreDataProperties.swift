//
//  Transaction+CoreDataProperties.swift
//  FinancePractice
//
//  Created by Karthik M S on 01/01/20.
//  Copyright © 2020 Zoho. All rights reserved.
//
//

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

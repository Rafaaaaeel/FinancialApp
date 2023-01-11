//
//  Payment+CoreDataProperties.swift
//  FinancialController
//
//  Created by Rafael Oliveira on 10/01/23.
//
//

import Foundation
import CoreData


extension Payment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Payment> {
        return NSFetchRequest<Payment>(entityName: "Payment")
    }

    @NSManaged public var name: String?
    @NSManaged public var value: NSDecimalNumber?
    @NSManaged public var debit: Debit?

}

extension Payment : Identifiable {

}

//
//  Debit+CoreDataProperties.swift
//  FinancialController
//
//  Created by Rafael Oliveira on 12/01/23.
//
//

import Foundation
import CoreData


extension Debit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Debit> {
        return NSFetchRequest<Debit>(entityName: "Debit")
    }

    @NSManaged public var name: String?
    @NSManaged public var total: NSDecimalNumber?
    @NSManaged public var image: String?
    @NSManaged public var color: Data?
    @NSManaged public var payment: NSSet?

}

// MARK: Generated accessors for payment
extension Debit {

    @objc(addPaymentObject:)
    @NSManaged public func addToPayment(_ value: Payment)

    @objc(removePaymentObject:)
    @NSManaged public func removeFromPayment(_ value: Payment)

    @objc(addPayment:)
    @NSManaged public func addToPayment(_ values: NSSet)

    @objc(removePayment:)
    @NSManaged public func removeFromPayment(_ values: NSSet)

}

extension Debit : Identifiable {

}

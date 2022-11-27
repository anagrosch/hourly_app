//
//  RoundingOption+CoreDataProperties.swift
//  Hourly
//
//  Created by Anastasia Grosch on 11/13/22.
//
//

import Foundation
import CoreData


extension RoundingOption {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RoundingOption> {
        return NSFetchRequest<RoundingOption>(entityName: "RoundingOption")
    }

    @NSManaged public var rounding: Bool

}

extension RoundingOption : Identifiable {

}

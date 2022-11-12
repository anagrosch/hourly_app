//
//  JobWages+CoreDataProperties.swift
//  Hourly
//
//  Created by Anastasia Grosch on 3/18/22.
//
//

import Foundation
import CoreData


extension JobWages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JobWages> {
        return NSFetchRequest<JobWages>(entityName: "JobWages")
    }

    @NSManaged public var pay1: Double
    @NSManaged public var pay2: Double
    @NSManaged public var pay3: Double
    @NSManaged public var pay4: Double
    @NSManaged public var pay5: Double

}

extension JobWages : Identifiable {

}

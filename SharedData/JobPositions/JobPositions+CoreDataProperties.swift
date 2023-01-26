//
//  JobPositions+CoreDataProperties.swift
//  Hourly
//
//  Created by Anastasia Grosch on 3/14/22.
//
//

import Foundation
import CoreData


extension JobPositions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JobPositions> {
        return NSFetchRequest<JobPositions>(entityName: "JobPositions")
    }

    @NSManaged public var job5name: String?
    @NSManaged public var job4name: String?
    @NSManaged public var job3name: String?
    @NSManaged public var job2name: String?
    @NSManaged public var job1name: String?

}

extension JobPositions : Identifiable {

}

//
//  Job4Info+CoreDataProperties.swift
//  Hourly
//
//  Created by Anastasia Grosch on 3/16/22.
//
//

import Foundation
import CoreData


extension Job4Info {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Job4Info> {
        return NSFetchRequest<Job4Info>(entityName: "Job4Info")
    }

    @NSManaged public var mondayHours: Int16
    @NSManaged public var tuesdayHours: Int16
    @NSManaged public var wednesdayHours: Int16
    @NSManaged public var thursdayHours: Int16
    @NSManaged public var fridayHours: Int16
    @NSManaged public var saturdayHours: Int16
    @NSManaged public var sundayHours: Int16

}

extension Job4Info : Identifiable {

}

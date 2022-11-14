//
//  Job2Info+CoreDataProperties.swift
//  Hourly
//
//  Created by Anastasia Grosch on 3/16/22.
//
//

import Foundation
import CoreData


extension Job2Info {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Job2Info> {
        return NSFetchRequest<Job2Info>(entityName: "Job2Info")
    }
    
    @NSManaged public var sundayHours: Int16
    @NSManaged public var mondayHours: Int16
    @NSManaged public var tuesdayHours: Int16
    @NSManaged public var wednesdayHours: Int16
    @NSManaged public var thursdayHours: Int16
    @NSManaged public var fridayHours: Int16
    @NSManaged public var saturdayHours: Int16

}

extension Job2Info : Identifiable {

}

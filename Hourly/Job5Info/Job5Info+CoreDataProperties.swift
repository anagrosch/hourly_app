//
//  Job5Info+CoreDataProperties.swift
//  Hourly
//
//  Created by Anastasia Grosch on 3/16/22.
//
//

import Foundation
import CoreData


extension Job5Info {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Job5Info> {
        return NSFetchRequest<Job5Info>(entityName: "Job5Info")
    }
    
    @NSManaged public var sundayHours: Int16
    @NSManaged public var mondayHours: Int16
    @NSManaged public var tuesdayHours: Int16
    @NSManaged public var wednesdayHours: Int16
    @NSManaged public var thursdayHours: Int16
    @NSManaged public var fridayHours: Int16
    @NSManaged public var saturdayHours: Int16

}

extension Job5Info : Identifiable {

}

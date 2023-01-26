//
//  HideButtons+CoreDataProperties.swift
//  Hourly
//
//  Created by Anastasia Grosch on 3/17/22.
//
//

import Foundation
import CoreData


extension HideButtons {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HideButtons> {
        return NSFetchRequest<HideButtons>(entityName: "HideButtons")
    }

    @NSManaged public var button1: Bool
    @NSManaged public var button2: Bool
    @NSManaged public var button3: Bool
    @NSManaged public var button4: Bool
    @NSManaged public var button5: Bool

}

extension HideButtons : Identifiable {

}

//
//  AppMode+CoreDataProperties.swift
//  Hourly
//
//  Created by Coding on 11/25/22.
//
//

import Foundation
import CoreData


extension AppMode {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppMode> {
        return NSFetchRequest<AppMode>(entityName: "AppMode")
    }

    @NSManaged public var darkMode: Int16

}

extension AppMode : Identifiable {

}

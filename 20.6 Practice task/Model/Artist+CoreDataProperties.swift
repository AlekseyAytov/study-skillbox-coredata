//
//  Artist+CoreDataProperties.swift
//  20.6 Practice task
//
//  Created by Alex Aytov on 5/31/23.
//
//

import Foundation
import CoreData


extension Artist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Artist> {
        return NSFetchRequest<Artist>(entityName: "Artist")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var gender: String?
    @NSManaged public var dob: Date?
    @NSManaged public var country: String?
    @NSManaged public var city: String?

}

extension Artist : Identifiable {

}

//
//  Artist+CoreDataClass.swift
//  20.6 Practice task
//
//  Created by Alex Aytov on 5/31/23.
//
//

import Foundation
import CoreData

@objc(Artist)
public class Artist: NSManagedObject {
    @nonobjc public static let entityName = "Artist"
}


enum Gender: String, CaseIterable, Codable {
    case male, female
}

enum ArtistProperties: String, CaseIterable {
    case firstName, lastName, gender, country, city
}

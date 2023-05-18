//
//  Model.swift
//  20.6 Practice task
//
//  Created by Alex Aytov on 5/10/23.
//

import Foundation

enum TaskPriority: String {
    case normal
    case important
}

enum TaskStatus: String {
    case planned
    case completed
}

protocol TaskProtocol {
    var title: String { get set }
    var priority: TaskPriority { get set }
    var status: TaskStatus { get set }
}

struct Task: TaskProtocol {
    var title: String
    
    var priority: TaskPriority
    
    var status: TaskStatus
}

// -------------------------------------

enum Gender: String {
    case male, female
}

protocol ArtistProtocol {
    var gender: Gender { get set }
    var firstName: String { get set }
    var lastName: String { get set }
    var dob: String { get set }
    var country: String { get set }
    var city: String { get set }
}

struct Artist: ArtistProtocol {
    var gender: Gender
    var firstName: String
    var lastName: String
    var dob: String
    var country: String
    var city: String
}

enum SortingField: CaseIterable {
    case firstname, lastName
}

enum SortingMethod: CaseIterable {
    case alphabetical, reverseAlphabetical
}

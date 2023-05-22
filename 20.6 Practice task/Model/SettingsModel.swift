//
//  SettingsModel.swift
//  20.6 Practice task
//
//  Created by Alex Aytov on 5/22/23.
//

import Foundation

enum SortingField: String, CaseIterable, Codable {
    case firstname, lastName
}

enum SortingMethod: String, CaseIterable, Codable {
    case alphabetical, reverseAlphabetical
}

struct Settings: Codable {
    var sortingField: SortingField
    var sortingMethod: SortingMethod
}

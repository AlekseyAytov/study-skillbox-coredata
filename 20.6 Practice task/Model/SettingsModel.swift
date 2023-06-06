//
//  SettingsModel.swift
//  20.6 Practice task
//
//  Created by Alex Aytov on 5/22/23.
//

import Foundation

struct Settings: Codable {
    var sortingField: ArtistProperties
    var ascending: Bool
}

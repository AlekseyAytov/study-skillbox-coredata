//
//  Service.swift
//  20.6 Practice task
//
//  Created by Alex Aytov on 5/10/23.
//

import Foundation

protocol ArtistInfoStorageProtocol {
    func loadArtists() -> [ArtistProtocol]
    func saveArtists(_ tasks: [ArtistProtocol]) -> Void
}

class ArtistInfoStorage: ArtistInfoStorageProtocol {
    
    private var storage = UserDefaults.standard
    var storageKey = "artists"
    
    func loadArtists() -> [ArtistProtocol] {
        let loadData = [
            Artist(gender: .male, firstName: "Lorenzo", lastName: "Lefevre", dob: "1991-02-18", country: "France", city: "Fort-de-France"),
            Artist(gender: .male, firstName: "Romário", lastName: "Costa", dob: "1971-05-12", country: "Brazil", city: "Mogi das Cruzes"),
            Artist(gender: .male, firstName: "Atiksh", lastName: "Shah", dob: "1999-05-10", country: "India", city: "Bijapur"),
            Artist(gender: .female, firstName: "Ilka", lastName: "Barentsen", dob: "1966-01-16", country: "Netherlands", city: "Opsterland"),
            Artist(gender: .female, firstName: "Selma", lastName: "Rasmussen", dob: "1960-01-04", country: "Denmark", city: "Kvistgaard")
        ]
//        var loadData:[ArtistProtocol] = []
//        let artistsFromStorage = storage.array(forKey: storageKey) as? [[String: String]] ?? []
//
//        for artist in artistsFromStorage {
//            guard let title = artist[TaskKey.title.rawValue],
//                  let priorityString = artist[TaskKey.priority.rawValue],
//                  let statusString = artist[TaskKey.status.rawValue] else { continue }
//
//            let priority: TaskPriority = priorityString == TaskPriority.normal.rawValue ? .normal : .important
//            let status: TaskStatus = statusString == TaskStatus.planned.rawValue ? .planned : .completed
//
//            loadData.append(Task(title: title, priority: priority, status: status))
//        }
        return loadData
    }
    
    func saveArtists(_ artists: [ArtistProtocol]) {
        
//        var arrayForStorage: [[String: String]] = []
//        artists.forEach { artist in
//            var oneElement: [String: String] = [:]
//            oneElement[TaskKey.title.rawValue] = artist.title
//
//            switch artist.priority {
//            case .normal:
//                oneElement[TaskKey.priority.rawValue] = TaskPriority.normal.rawValue
//            case .important:
//                oneElement[TaskKey.priority.rawValue] = TaskPriority.important.rawValue
//            }
//
//            switch artist.status {
//            case .completed:
//                oneElement[TaskKey.status.rawValue] = TaskStatus.completed.rawValue
//            case .planned:
//                oneElement[TaskKey.status.rawValue] = TaskStatus.planned.rawValue
//            }
//
//            arrayForStorage.append(oneElement)
//        }
//
//        storage.set(arrayForStorage, forKey: storageKey)
        print("Данные сохранены")
    }
}

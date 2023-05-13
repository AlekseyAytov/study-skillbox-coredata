//
//  Service.swift
//  20.6 Practice task
//
//  Created by Alex Aytov on 5/10/23.
//

import Foundation

protocol TaskStorageProtocol {
    func loadTasks() -> [TaskProtocol]
    func saveTasks(_ tasks: [TaskProtocol]) -> Void
}

class TaskStorage: TaskStorageProtocol {
    
    private var storage = UserDefaults.standard
    var storageKey = "tasks"
    
    private enum TaskKey: String {
        case title
        case priority
        case status
    }
    
    func loadTasks() -> [TaskProtocol] {
//        let testData = [
//            Task(title: "have sleep", priority: .normal, status: .planned),
//            Task(title: "Task 1", priority: .normal, status: .planned),
//            Task(title: "Task 2", priority: .important, status: .completed),
//        ]
        var loadData:[TaskProtocol] = []
        let tasksfromStorage = storage.array(forKey: storageKey) as? [[String: String]] ?? []
        
        for task in tasksfromStorage {
            guard let title = task[TaskKey.title.rawValue],
                  let priorityString = task[TaskKey.priority.rawValue],
                  let statusString = task[TaskKey.status.rawValue] else { continue }
            
            let priority: TaskPriority = priorityString == TaskPriority.normal.rawValue ? .normal : .important
            let status: TaskStatus = statusString == TaskStatus.planned.rawValue ? .planned : .completed
            loadData.append(Task(title: title, priority: priority, status: status))
        }
        print("Данные выгружены")
        return loadData
    }
    
    func saveTasks(_ tasks: [TaskProtocol]) {
        var arrayForStorage: [[String: String]] = []
        tasks.forEach { task in
            var oneElement: [String: String] = [:]
            oneElement[TaskKey.title.rawValue] = task.title
            
            switch task.priority {
            case .normal:
                oneElement[TaskKey.priority.rawValue] = TaskPriority.normal.rawValue
            case .important:
                oneElement[TaskKey.priority.rawValue] = TaskPriority.important.rawValue
            }
            
            switch task.status {
            case .completed:
                oneElement[TaskKey.status.rawValue] = TaskStatus.completed.rawValue
            case .planned:
                oneElement[TaskKey.status.rawValue] = TaskStatus.planned.rawValue
            }
            
            arrayForStorage.append(oneElement)
        }
        
        storage.set(arrayForStorage, forKey: storageKey)
        print("Данные сохранены")
    }
}

// ----------------------------------------

protocol ArtistInfoStorageProtocol {
    func loadArtists() -> [ArtistProtocol]
    func saveArtists(_ tasks: [ArtistProtocol]) -> Void
}

class ArtistInfoStorage: ArtistInfoStorageProtocol {
    
    private var storage = UserDefaults.standard
    var storageKey = "artists"
    
    private enum TaskKey: String {
        case title
        case priority
        case status
    }
    
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
        print("Данные выгружены")
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

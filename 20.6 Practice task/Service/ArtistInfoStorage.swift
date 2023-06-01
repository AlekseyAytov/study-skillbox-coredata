//
//  Service.swift
//  20.6 Practice task
//
//  Created by Alex Aytov on 5/10/23.
//

import Foundation
import CoreData

class ArtistInfoStorage {
    static let shared = ArtistInfoStorage()
    private init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Artist.entityName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                print(storeDescription.url?.absoluteString ?? "")
            }
        })
        return container
    }()
    
    private lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
//        for privateContext
//        return persistentContainer.newBackgroundContext()
        
//        let newContext = NSManagedObjectContext(concurrencyType:.mainQueueConcurrencyType)
    }()
    
    func fetchObjects() -> [Artist] {
        let fetchRequest = Artist.fetchRequest()
        let artistsList = try? context.fetch(fetchRequest)
        return artistsList ?? []
    }
    
    func insertNewObject(newArtist: [ArtistProperties: String], birth: Date) -> Artist {
        // first way
        let newObject =  NSEntityDescription.insertNewObject(forEntityName: Artist.entityName, into: self.context) as! Artist
         
        newObject.firstName = newArtist[.firstName]
        newObject.lastName  = newArtist[.lastName]
        newObject.gender    = newArtist[.gender]
        newObject.dob       = birth
        newObject.country   = newArtist[.country]
        newObject.city      = newArtist[.city]
        
        self.saveContext()
        return newObject
    }
    
    func deleteOblect(artist: Artist) {
        context.delete(artist)
        self.saveContext()
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

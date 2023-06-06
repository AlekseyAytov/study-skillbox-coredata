//
//  ArtistInfoStorageFRC.swift
//  20.6 Practice task
//
//  Created by Alex Aytov on 6/5/23.
//

import UIKit
import CoreData

class ArtistInfoStorageFRC {
    static let shared = ArtistInfoStorageFRC()
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
    }()
    
    func  getFetchController(sortingKey: String, ascending: Bool) -> NSFetchedResultsController<Artist> {
        let fetchRequest = Artist.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: sortingKey, ascending: ascending)]
        
        let fetchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchController.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return fetchController
    }
    
    func insertNewObject(newArtist: [ArtistProperties: String], birth: Date) {
        let newObject =  NSEntityDescription.insertNewObject(forEntityName: Artist.entityName, into: self.context) as! Artist
         
        newObject.firstName = newArtist[.firstName]
        newObject.lastName  = newArtist[.lastName]
        newObject.gender    = newArtist[.gender]
        newObject.dob       = birth
        newObject.country   = newArtist[.country]
        newObject.city      = newArtist[.city]
        
        self.saveContext()
    }
    
    func deleteOblect(artist: Artist) {
        context.delete(artist)
        self.saveContext()
    }
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

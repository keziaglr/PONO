//
//  CoreDataContainer.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 15/11/23.
//

import CoreData

fileprivate let containerName = "pono.coredata-container"

struct CoreDataContainer {
    
    static let shared = CoreDataContainer()
    
    private let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: containerName)
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Unresolved error
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func read<T: NSManagedObject>(_ entityType: T.Type, predicate: NSPredicate? = nil, sorts: [NSSortDescriptor]? = nil, completion: @escaping (Result<[T]?, Error>) -> Void) {
        guard let fetchRequest: NSFetchRequest<T> = T.fetchRequest() as? NSFetchRequest<T> else {
            completion(.failure(CoreDataError.fetchError))
            return
        }
        
        if let predicate {
            fetchRequest.predicate = predicate
        }
        
        if let sorts {
            fetchRequest.sortDescriptors = sorts
        }
        
        do {
            let result = try container.viewContext.fetch(fetchRequest)
            completion(.success(result))
        } catch {
            completion(.failure(error))
        }
    }
    
    func create<T: NSManagedObject>(_ type: T.Type) -> T? {
        guard let entityName = T.entity().name else {
            return nil
        }
        let object = NSEntityDescription.insertNewObject(forEntityName: entityName, into: container.viewContext) as? T
        return object
    }
    
    func save() throws {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                let nserror = error as NSError
                throw nserror
            }
        }
    }
    
    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
    }
    
}

enum CoreDataError: Error {
    case dataUnavailable
    case fetchError
    case any(String)
}

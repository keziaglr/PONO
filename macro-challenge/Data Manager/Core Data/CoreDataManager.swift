//
//  CoreDataManager.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 15/11/23.
//

import Foundation
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: CoreDataConst.NAME_DATA_MODEL)
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error laoding Core Data. \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
            print("Data Success Updated")
        } catch let error {
            print("Error saving Core Data. \(error.localizedDescription)")
        }
    }
}

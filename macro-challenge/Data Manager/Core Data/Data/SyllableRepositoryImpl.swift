//
//  SyllableLocalDataImpl.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 16/11/23.
//

import Foundation
import CoreData

class SyllableRepositoryImpl : SyllableRepository {
    
    private let manager = CoreDataManager.instance
    private let backgroundQueue = DispatchQueue.global(qos: .background)

    func getTotalSyllable(success: @escaping (Int) -> Void, error: @escaping (String) -> Void) {
        backgroundQueue.async {
            let request: NSFetchRequest<SyllableEntity> = SyllableEntity.fetchRequest()
            do {
                let syllableList = try self.manager.context.fetch(request)
                DispatchQueue.main.async {
                    success(syllableList.count)
                }
            } catch let errorData {
                DispatchQueue.main.async {
                    error(errorData.localizedDescription)
                }
            }
        }
    }
    
    func getSyllableList(success: @escaping ([SyllableEntity]) -> Void, error: @escaping (String) -> Void) {
        backgroundQueue.async {
            let request: NSFetchRequest<SyllableEntity> = SyllableEntity.fetchRequest()
            do {
                let syllableList = try self.manager.context.fetch(request)
                DispatchQueue.main.async {
                    success(syllableList)
                }
            } catch let errorData {
                DispatchQueue.main.async {
                    error(errorData.localizedDescription)
                }
            }
        }
    }

}

//
//  WordLocalDataImpl.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 16/11/23.
//

import Foundation
import CoreData

class WordRepositoryImpl: WordRepository {
    private let manager = CoreDataManager.instance
    private let backgroundQueue = DispatchQueue.global(qos: .background)
    
    func getTotalWord(success: @escaping (Int) -> Void, error: @escaping (String) -> Void) {
        backgroundQueue.async {
            let request: NSFetchRequest<WordEntity> = WordEntity.fetchRequest()
            do {
                let wordList = try self.manager.context.fetch(request)
                DispatchQueue.main.async {
                    success(wordList.count)
                }
            } catch let errorMessage {
                DispatchQueue.main.async {
                    error(errorMessage.localizedDescription)
                }
            }
        }
    }
    
    func getWordList(success: @escaping ([WordEntity]) -> Void, error: @escaping (String) -> Void) {
        backgroundQueue.async {
            let request: NSFetchRequest<WordEntity> = WordEntity.fetchRequest()
            do {
                let wordList = try self.manager.context.fetch(request)
                DispatchQueue.main.async {
                    success(wordList)
                }
            } catch let errorMessage {
                DispatchQueue.main.async {
                    error(errorMessage.localizedDescription)
                }
            }
        }
    }
}

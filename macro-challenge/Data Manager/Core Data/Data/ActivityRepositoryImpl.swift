//
//  ActivityLocalDataImpl.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 16/11/23.
//

import Foundation
import CoreData

class ActivityRepositoryImpl: ActivityRepository {
    private let manager = CoreDataManager.instance
    private let backgroundQueue = DispatchQueue.global(qos: .background)
    
    func getList(success: @escaping ([ActivityEntity]) -> Void, error: @escaping (String) -> Void) {
        backgroundQueue.async {
            let request: NSFetchRequest<ActivityEntity> = ActivityEntity.fetchRequest()
            do {
                let activityList = try self.manager.context.fetch(request)
                DispatchQueue.main.async {
                    success(activityList)
                }
            } catch let errorData {
                DispatchQueue.main.async {
                    error(errorData.localizedDescription)
                }
            }
        }
        
    }
    
    func create(wordId: String, syllable1: String, syllable2: String, success: @escaping () -> Void, error: @escaping (String?) -> Void) {
        backgroundQueue.async {
            let activityEntity = ActivityEntity(context: self.manager.context)
            let wordEntity = WordEntity(context: self.manager.context)
            let syllableEntity1 = SyllableEntity(context: self.manager.context)
            let syllableEntity2 = SyllableEntity(context: self.manager.context)
            
            wordEntity.id = wordId
            wordEntity.countPronunciationWrong = 0
            wordEntity.countPronunciationCorrect = 0
            wordEntity.timeStamp = Date()
            
            syllableEntity1.id = syllable1
            syllableEntity1.countCardRecognizeCorrect = 0
            syllableEntity1.countCardRecognizeIncorrect = 0
            syllableEntity1.countPronunciationWrong = 0
            syllableEntity1.countPronunciationCorrect = 0
            syllableEntity1.timeStamp = Date()
            
            syllableEntity2.id = syllable2
            syllableEntity2.countCardRecognizeCorrect = 0
            syllableEntity2.countCardRecognizeIncorrect = 0
            syllableEntity2.countPronunciationWrong = 0
            syllableEntity2.countPronunciationCorrect = 0
            syllableEntity2.timeStamp = Date()
            
            activityEntity.id = UUID().uuidString
            activityEntity.timeStamp = Date()
            
            wordEntity.addToWordToActivity(activityEntity)
            syllableEntity1.addToSyllableToWord(wordEntity)
            syllableEntity2.addToSyllableToWord(wordEntity)
            self.manager.save()
            DispatchQueue.main.async {
                success()
            }
        }
        
    }
    
    func updateWord(activityId: String, isPronunciationCorrect: Bool?, success: @escaping () -> Void, error: @escaping (String) -> Void) {
        backgroundQueue.async {
            switch self.getById(activityId: activityId) {
            case.success(let activityData):
                if let pronunciationCorrect = isPronunciationCorrect {
                    if pronunciationCorrect {
                        activityData.activityToWord?.countPronunciationCorrect += 1
                    } else {
                        activityData.activityToWord?.countPronunciationWrong -= 1
                    }
                }
                self.manager.save()
                DispatchQueue.main.async {
                    success()
                }
            case.failure(let errorMessage):
                DispatchQueue.main.async {
                    error(errorMessage.localizedDescription)
                }
            }
        }
    }
    
    func updateSyllable(activityId: String, syllableId: String, isCardCorrect: Bool?, isPronunciationCorrect: Bool?, success: @escaping () -> Void, error: @escaping (String) -> Void) {
        backgroundQueue.async {
            switch self.getById(activityId: activityId) {
            case .success(let activityData):
                if let syllableList = activityData.activityToWord?.wordToSyllable?.allObjects as? [SyllableEntity] {
                    if let syllableData = syllableList.first(where: { $0.id == syllableId }) {
                        if let cardCorrect = isCardCorrect {
                            if cardCorrect {
                                syllableData.countCardRecognizeCorrect += 1
                            } else {
                                syllableData.countCardRecognizeIncorrect += 1
                            }
                        }
                        if let pronunciationCorrect = isPronunciationCorrect {
                            if pronunciationCorrect {
                                syllableData.countPronunciationCorrect += 1
                            } else {
                                syllableData.countPronunciationWrong += 1
                            }
                        }
                        DispatchQueue.main.async {
                            success()
                        }
                    }
                }
            case .failure(let errorMessage):
                DispatchQueue.main.async {
                    error(errorMessage.localizedDescription)
                }
            }
        }
    }
    
    private func getById(activityId: String) -> Result<ActivityEntity, MyError> {
        let fetchRequest: NSFetchRequest<ActivityEntity> = ActivityEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", activityId)

        do {
            if let results = try self.manager.context.fetch(fetchRequest).first {
                return .success(results)
            } else {
                return .failure(.customError("Activity Not Found"))
            }
        } catch let errorMessage {
            return .failure(.customError("Getting Activity has been error \(errorMessage.localizedDescription)"))
        }
    }
    
}

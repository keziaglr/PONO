//
//  CoreDataViewModel.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 15/11/23.
//

import Foundation
import CoreData

class CoreDataViewModelImpl: ObservableObject, CoreDataViewModel {
    private let activityRepository: ActivityRepository
    
    @Published var activities: [ActivityEntity] = []
    @Published var words: [WordEntity] = []
    
    let manager = CoreDataManager.instance
    
    init(activityRepository: ActivityRepository = ActivityRepositoryImpl()) {
        self.activityRepository = activityRepository
    }
    //Contoh Contoh Pengunaannya
    func getActivityList() {
        activityRepository.getList { activityList in
            for activity in activityList {
                print("ID -> \(activity)")
                if let word = activity.activityToWord {
                    print("Word Correct -> \(word.countPronunciationCorrect)")
                    print("Word Wrong -> \(word.countPronunciationWrong)")
                    if let syllables = word.wordToSyllable?.allObjects as? [SyllableEntity] {
                        print("Syllable:")
                        for syllable in syllables {
                            print("Syllable ID -> \(syllable.id)")
                            
                        }
                    } else {
                        print("No Syllable")
                    }
                    
                }
            }
        } error: { errorMessage in
            print("VM Error \(errorMessage)")
        }

    }
    //Contoh Contoh Pengunaannya
    func addActivity() {
        activityRepository.create(wordId: "wordId", syllable1: "syllable1", syllable2: "syllable2") {
            print("Sukses")
        } error: { errorMessage in
            if let error = errorMessage {
                print("Error \(error)")
            }
        }

//        let activity = ActivityEntity(context: manager.context)
//        activity.id = "fff"
//        activity.timeStamp = Date()
//        let wordEntity = WordEntity(context: manager.context)
//        wordEntity.id = UUID().uuidString
//        wordEntity.countPronunciationWrong = 55
//        wordEntity.countPronunciationCorrect = 56
//        activity.activityToWord = wordEntity
//        manager.save()
    }
    //Contoh Contoh Pengunaannya
    func getData() {
        let request = NSFetchRequest<ActivityEntity>(entityName: "ActivityEntity")
        request.predicate = NSPredicate(format: "id == %@", "xxxxx")
        do {
            let activity = try manager.context.fetch(request)
//            print("qwer Activity \(activity.activityToWord)")
            print("qwer Activity \(activity.first?.id)")
            print("qwer Activity \(activity.first?.activityToWord?.countPronunciationCorrect)")
            print("qwer Activity \(activity.first?.activityToWord?.countPronunciationWrong)")
        } catch let error {
            print("Error Fetching Spesific. \(error.localizedDescription)")
        }
    }
    //Contoh Contoh Pengunaannya
    func updateData() {
        let request: NSFetchRequest<ActivityEntity> = ActivityEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", "asdfasdf")
        
        do {
            let listActivity = try manager.context.fetch(request)
            if let activity = listActivity.first {
                activity.activityToWord?.countPronunciationCorrect = 55
                activity.activityToWord?.countPronunciationWrong = 33
            }
        } catch let error {
            print("ERROR Update \(error.localizedDescription)")
        }
    }
}

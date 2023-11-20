//
//  ReportManager.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 20/11/23.
//

import Foundation

class ReportManager {
    
    func getPractices(completion: @escaping ([Practice]) -> Void) {
        CoreDataService.shared.read(Practice.self) { result in
            switch result {
            case .success(let practices):
                completion(practices ?? [])
            case .failure(_):
                completion([])
            }
        }
    }
    
    func getPracticedWords(completion: @escaping ([PracticedWord]) -> Void) {
        CoreDataService.shared.read(PracticedWord.self) { result in
            switch result {
            case .success(let practicedWords):
                completion(practicedWords ?? [])
            case .failure(_):
                completion([])
            }
        }
    }
    
    func getPracticedSyllables(completion: @escaping ([PracticedSyllable]) -> Void) {
        CoreDataService.shared.read(PracticedSyllable.self) { result in
            switch result {
            case .success(let practicedSyllables):
                completion(practicedSyllables ?? [])
            case .failure(_):
                completion([])
            }
        }
    }
    
    func recordPractice(word: PracticedWord, syllables: [PracticedSyllable]) {
        guard let practice = createPractice(word) else { return }
        let timeStamp = Date()
        practice.updatedAt = timeStamp
        word.updatedAt = timeStamp
        syllables.forEach { $0.updatedAt = timeStamp }
        do {
            try CoreDataService.shared.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func logPracticedSyllable(_ syllable: Syllable, isPronunciationCorrect: Bool, isCardRecognitionCorrect: Bool) async -> PracticedSyllable? {
        if let foundPracticedSyllable = await findPracticedSyllable(syllable) {
            foundPracticedSyllable.increasePronunciation(isCorrect: isPronunciationCorrect)
            foundPracticedSyllable.increaseCardRecognition(isCorrect: isCardRecognitionCorrect)
            return foundPracticedSyllable
        } else {
            guard let practicedSyllable = CoreDataService.shared.create(PracticedSyllable.self) else {
                return nil
            }
            practicedSyllable.id = syllable.id
            practicedSyllable.increasePronunciation(isCorrect: isPronunciationCorrect)
            practicedSyllable.increaseCardRecognition(isCorrect: isCardRecognitionCorrect)
            practicedSyllable.createdAt = Date()
            return practicedSyllable
        }
    }
    
    func logPracticedWord(_ word: Word, isPronunciationCorrect: Bool) async -> PracticedWord? {
        if let foundPracticedWord = await findPracticedWord(word) {
            foundPracticedWord.increasePronunciation(isCorrect: isPronunciationCorrect)
            return foundPracticedWord
        } else {
            guard let practicedWord = CoreDataService.shared.create(PracticedWord.self) else {
                return nil
            }
            practicedWord.id = word.content
            practicedWord.increasePronunciation(isCorrect: isPronunciationCorrect)
            practicedWord.createdAt = Date()
            return practicedWord
        }
    }
    
    private func createPractice(_ practicedWord: PracticedWord) -> Practice? {
        guard let practice = CoreDataService.shared.create(Practice.self) else {
            return nil
        }
        practice.id = UUID()
        practice.practicedWord = practicedWord
        practice.createdAt = Date()
        return practice
    }
    
    private func findPracticedSyllable(_ syllable: Syllable) async -> PracticedSyllable? {
        await withCheckedContinuation { continuation in
            let predicate = NSPredicate(format: "id == %@", syllable.id as NSUUID)
            CoreDataService.shared.read(PracticedSyllable.self, predicate: predicate) { result in
                switch result {
                case .success(let data):
                    continuation.resume(returning: data?.first)
                case .failure(_):
                    continuation.resume(returning: nil)
                }
            }
        }
    }
    
    private func findPracticedWord(_ word: Word) async -> PracticedWord? {
        await withCheckedContinuation { continuation in
            let predicate = NSPredicate(format: "id == %@", word.content as NSString)
            CoreDataService.shared.read(PracticedWord.self, predicate: predicate) { result in
                switch result {
                case .success(let data):
                    continuation.resume(returning: data?.first)
                case .failure(_):
                    continuation.resume(returning: nil)
                }
            }
        }
    }
}

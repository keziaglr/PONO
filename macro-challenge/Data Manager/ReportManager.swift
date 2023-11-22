//
//  ReportManager.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 20/11/23.
//

import Foundation

struct ReportManager {
    
    static let shared = ReportManager()
    
    private init() {}
    
    func getPractices() async -> [Practice] {
        await withCheckedContinuation { continuation in
            CoreDataContainer.shared.read(Practice.self) { result in
                switch result {
                case .success(let practices):
                    continuation.resume(returning: practices ?? [])
                case .failure(_):
                    continuation.resume(returning: [])
                }
            }
        }
    }
    
    func getPracticedWords() async -> [PracticedWord] {
        await withCheckedContinuation { continuation in
            CoreDataContainer.shared.read(PracticedWord.self) { result in
                switch result {
                case .success(let practicedWords):
                    continuation.resume(returning: practicedWords ?? [])
                case .failure(_):
                    continuation.resume(returning: [])
                }
            }
        }
    }
    
    func getPracticedSyllables() async -> [PracticedSyllable] {
        await withCheckedContinuation { continuation in
            CoreDataContainer.shared.read(PracticedSyllable.self) { result in
                switch result {
                case .success(let practicedSyllables):
                    continuation.resume(returning: practicedSyllables ?? [])
                case .failure(_):
                    continuation.resume(returning: [])
                }
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
            try CoreDataContainer.shared.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func logPracticedSyllable(_ syllable: Syllable, isPronunciationCorrect: Bool, isCardRecognitionCorrect: Bool) async -> PracticedSyllable? {
        if let foundPracticedSyllable = await findPracticedSyllable(syllable) {
            foundPracticedSyllable.increasePronunciationCount(isCorrect: isPronunciationCorrect)
            foundPracticedSyllable.increaseCardRecognitionCount(isCorrect: isCardRecognitionCorrect)
            return foundPracticedSyllable
        } else {
            guard let practicedSyllable = CoreDataContainer.shared.create(PracticedSyllable.self) else {
                return nil
            }
            practicedSyllable.id = syllable.id
            practicedSyllable.increasePronunciationCount(isCorrect: isPronunciationCorrect)
            practicedSyllable.increaseCardRecognitionCount(isCorrect: isCardRecognitionCorrect)
            practicedSyllable.createdAt = Date()
            return practicedSyllable
        }
    }
    
    func logPracticedWord(_ word: Word, isPronunciationCorrect: Bool) async -> PracticedWord? {
        if let foundPracticedWord = await findPracticedWord(word) {
            foundPracticedWord.increasePronunciationCount(isCorrect: isPronunciationCorrect)
            return foundPracticedWord
        } else {
            guard let practicedWord = CoreDataContainer.shared.create(PracticedWord.self) else {
                return nil
            }
            practicedWord.id = word.content
            practicedWord.increasePronunciationCount(isCorrect: isPronunciationCorrect)
            practicedWord.createdAt = Date()
            return practicedWord
        }
    }
    
    private func createPractice(_ practicedWord: PracticedWord) -> Practice? {
        guard let practice = CoreDataContainer.shared.create(Practice.self) else {
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
            CoreDataContainer.shared.read(PracticedSyllable.self, predicate: predicate) { result in
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
            CoreDataContainer.shared.read(PracticedWord.self, predicate: predicate) { result in
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

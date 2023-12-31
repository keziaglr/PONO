//
//  LearningFlowScreenViewModel.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 15/11/23.
//

import SwiftUI

class LearningFlowScreenViewModel: ObservableObject {
    
    @Published var learningWord: Word? = nil
    @Published var activityInstruction: Instruction? = nil
    @Published var activeLearningActivity : LearningActivity? = nil
    @Published var progress: CGFloat = .zero
    
    private let contentManager = ContentManager.shared
    private let reportManager = ReportManager.shared
    
    private var practicedWordRecord: PracticedWordRecord?
    private var practicedSyllableRecords: [PracticedSyllableRecord]?
    
    private var activityOrder: [LearningActivity] {
        guard let learningWord else { return [] }
        return [
            .breakWord(learningWord),
            .card(learningWord, .firstSyllable),
            .pronunciation(learningWord, .firstSyllable),
            .card(learningWord, .secondSyllable),
            .pronunciation(learningWord, .secondSyllable),
            .combineSyllable(learningWord),
            .pronunciation(learningWord, nil),
            .endStage(learningWord)
        ]
    }
    
    private var level: Level = .easy
    private var words: [Word] = []
    
    init() {
        generateWordByLevel()
        activeLearningActivity = activityOrder.first
    }
    
    func navigateToNextActivity() {
        guard !activityOrder.isEmpty else { return }
        
        guard let activeLearningActivity else {
            self.activeLearningActivity = activityOrder.first
            return
        }
        
        guard let currentActivityIndex = activityOrder.firstIndex(of: activeLearningActivity) else {
            self.activeLearningActivity = activityOrder.first
            return
        }
        
        let nextActivityIndex = currentActivityIndex + 1
        
        guard let nextActivity = activityOrder[safe: nextActivityIndex] else {
            // Restart the activity with higher level
            progress = 0
            increaseLevel()
            generateWordByLevel()
            self.activeLearningActivity = activityOrder.first
            return
        }
        
        self.activeLearningActivity = nextActivity
        updateProgress(nextActivityIndex)
    }
    
    private func updateProgress(_ activityIndex: Int) {
        guard activityIndex < activityOrder.count else { return }
        progress = CGFloat(CGFloat(activityIndex) / CGFloat(activityOrder.count - 1))
    }
    
    private func increaseLevel() {
        level = level.nextLevel()
    }
    
    private func generateWordByLevel() {
        words = contentManager.words
        var word: Word?
        if level == .easy {
            word = words.filter { $0.level == 0 }.randomElement()
        } else if level == .medium {
            word = words.filter { $0.level == 1 }.randomElement()
        } else if level == .hard {
            word = words.filter { $0.level == 2 }.randomElement()
        }
        learningWord = word
    }
    
    func logWordPronunciationPractice(_ word: Word, isCorrect: Bool) {
        let newRecord = PracticedWordRecord(word: word,
                                            isPronunciationCorrect: isCorrect)
        practicedWordRecord = newRecord
    }
    
    func logSyllablePronunciationPractice(_ syllable: Syllable, isCorrect: Bool) {
        if let practicedSyllableRecords {
            if let record = practicedSyllableRecords.first(where: { $0.syllable == syllable }) {
                let newRecord = PracticedSyllableRecord(syllable: syllable,
                                                        isPronunciationCorrect: isCorrect,
                                                        isCardRecognitionCorrect: record.isCardRecognitionCorrect)
                self.practicedSyllableRecords?.removeAll(where: { $0 == record })
                self.practicedSyllableRecords?.append(newRecord)
            } else {
                let newRecord = PracticedSyllableRecord(syllable: syllable,
                                                        isPronunciationCorrect: isCorrect,
                                                        isCardRecognitionCorrect: nil)
                self.practicedSyllableRecords?.append(newRecord)
            }
        } else {
            let newRecord = PracticedSyllableRecord(syllable: syllable,
                                                    isPronunciationCorrect: isCorrect,
                                                    isCardRecognitionCorrect: nil)
            practicedSyllableRecords = [newRecord]
        }
        
    }
    
    func logSyllableCardPractice(_ syllable: Syllable, isCorrect: Bool) {
        if let practicedSyllableRecords {
            if let record = practicedSyllableRecords.first(where: { $0.syllable == syllable }) {
                let newRecord = PracticedSyllableRecord(syllable: syllable,
                                                        isPronunciationCorrect: record.isPronunciationCorrect,
                                                        isCardRecognitionCorrect: isCorrect)
                self.practicedSyllableRecords?.removeAll(where: { $0 == record })
                self.practicedSyllableRecords?.append(newRecord)
            } else {
                let newRecord = PracticedSyllableRecord(syllable: syllable,
                                                        isPronunciationCorrect: nil,
                                                        isCardRecognitionCorrect: isCorrect)
                self.practicedSyllableRecords?.append(newRecord)
            }
        } else {
            let newRecord = PracticedSyllableRecord(syllable: syllable,
                                                    isPronunciationCorrect: nil,
                                                    isCardRecognitionCorrect: isCorrect)
            practicedSyllableRecords = [newRecord]
        }
    }
    
    func recordActivity() {
        guard let practicedWordRecord, let practicedSyllableRecords else { return }
        Task {
            guard let practicedWord = await reportManager.logPracticedWord(practicedWordRecord.word, isPronunciationCorrect: practicedWordRecord.isPronunciationCorrect ?? false) else { return }
            
            var practicedSyllables: [PracticedSyllable] = []
            
            for practicedSyllableRecord in practicedSyllableRecords {
                if let practicedSyllable = await reportManager.logPracticedSyllable(practicedSyllableRecord.syllable, isPronunciationCorrect: practicedSyllableRecord.isPronunciationCorrect ?? false, isCardRecognitionCorrect: practicedSyllableRecord.isCardRecognitionCorrect ?? false) {
                    practicedSyllables.append(practicedSyllable)
                }
            }
            
            reportManager.recordPractice(word: practicedWord, syllables: practicedSyllables)
            
            self.practicedWordRecord = nil
            self.practicedSyllableRecords = nil
        }
    }
}

struct PracticedSyllableRecord: Equatable {
    let syllable: Syllable
    let isPronunciationCorrect: Bool?
    let isCardRecognitionCorrect: Bool?
}

struct PracticedWordRecord: Equatable {
    let word: Word
    let isPronunciationCorrect: Bool?
}

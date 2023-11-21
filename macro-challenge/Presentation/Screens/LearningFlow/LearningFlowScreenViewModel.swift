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
    
}

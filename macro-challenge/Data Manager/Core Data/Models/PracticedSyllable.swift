//
//  PracticedSyllable.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 20/11/23.
//

import Foundation

extension PracticedSyllable {
    func increasePronunciationCount(isCorrect: Bool) {
        if isCorrect {
            countPronunciationCorrect = countPronunciationCorrect + 1
        } else {
            countPronunciationWrong = countPronunciationWrong + 1
        }
    }
    
    func increaseCardRecognitionCount(isCorrect: Bool) {
        if isCorrect {
            countCardRecognizeCorrect = countCardRecognizeCorrect + 1
        } else {
            countCardRecognizeWrong = countCardRecognizeWrong + 1
        }
    }
    
    var totalPractices: Int {
        Int(countPronunciationWrong + countPronunciationCorrect)
    }
}

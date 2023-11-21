//
//  LearningActivity.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 29/10/23.
//

import Foundation

enum LearningActivity: Equatable {
    case breakWord(Word)
    case card(Word, SyllableOrder)
    case pronunciation(Word, SyllableOrder?)
    case combineSyllable(Word)
    case endStage(Word)
}

enum SyllableOrder {
    case firstSyllable
    case secondSyllable
}

//
//  PreviewDataResources.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 15/11/23.
//

import Foundation

enum PreviewDataResources {
    static let syllable = Syllable(id: UUID(uuidString: "dc6e850b-485a-4e23-a1c3-12a0a1dab4c0")!, content: "ba")
    
    static let word = Word(content: "baba", level: 0, syllables: [syllable, syllable])
}

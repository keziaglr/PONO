//
//  SyllableViewModel.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 23/10/23.
//

import SwiftUI

class FlowScreenViewModel: ObservableObject {
    
    private var syllables: [Syllable] = []
    
    private(set) var word: Word? = nil
    
    init() {
        getSyllables()
        getWord()
    }
    
    func getSyllables() {
        syllables = ContentManager.shared.syllables
    }
    
    func getWord() {
        word = generateWord()
    }
    
    func generateWord() -> Word {
        if syllables.isEmpty {
            getSyllables()
        }

        let randomIndex1 = Int.random(in: 0..<syllables.count)
        var randomIndex2 = Int.random(in: 0..<syllables.count)

        while randomIndex2 == randomIndex1 {
            randomIndex2 = Int.random(in: 0..<syllables.count)
        }

        let syllable1 = syllables[randomIndex1]
        let syllable2 = syllables[randomIndex2]
        
        return Word(syllables: [syllable1, syllable2])
    }

}

//
//  SyllableViewModel.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 23/10/23.
//

import SwiftUI

class FlowScreenViewModel: ObservableObject {
    
    var am = AudioManager()
    
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

    func playInstruction(_ activity: Activity) {
        switch activity {
        case .beforeBreakWord(let array):
            let syllables = array.compactMap { $0.content }
            am.playQueue(["before_break-word(1)", syllables[0], syllables[1], "before_break-word(2)"])
            break
        case .afterBreakWord(let array):
            let syllables = array.compactMap { $0.content }
            am.playQueue(["after_break-word(1)", syllables[0], syllables[1], "after_break-word(2)", syllables[0],"after_break-word(3)", syllables[1]])
            break
        case .beforeCard(let syllable):
            am.playQueue(["before_card(1)", syllable.content,"before_card(2)"])
            break
        case .afterCard:
            am.playQueue(["after_card(1)"])
            break
        case .wrongCard:
            am.playQueue(["after_card(2-wrong)"])
            break
        case .correctCard:
            am.playQueue(["after_card(2-correct)"])
            break
        case .beforeRead(let array):
            var inst = ["before_spelling"]
            let syllable = array.compactMap { $0.content }
            inst.append(contentsOf: syllable)
            am.playQueue(inst)
            break
        case .afterRead:
            am.playQueue(["after_spelling"])
            break
        case .beforeBlendWord:
            am.playQueue(["before_blend-word"])
            break
        case .afterBlendWord:
            am.playQueue(["after_blend-word"])
            break
        }
    }
}

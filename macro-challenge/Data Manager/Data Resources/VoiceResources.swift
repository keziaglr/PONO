//
//  VoiceResources.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 15/11/23.
//

import Foundation

enum Letter: String {
    case a
    case b
    case c
    case d
    case e
    case eh
    case i
    case m
    case n
    case o
    case p
    case u
}

enum VoiceResources {
    static func voice(for syllable: Syllable) -> String {
        syllable.content
    }
    
    static func voice(for letter: Letter) -> String {
        letter.rawValue
    }
    
    static func breakWordActivityOpeningInstruction(_ word: Word) -> Instruction {
        let text = "Pecahkan kata ini"
        var voices = ["before_break-word(1)"]
        voices.append(contentsOf: word.syllables.compactMap { $0.content })
        voices.append("before_break-word(2)")
        return Instruction(text: text, voices: voices)
    }
    
    static func breakWordActivityClosingInstruction(_ word: Word) -> Instruction {
        let firstSyllable = word.syllable(at: 0)
        let secondSyllable = word.syllable(at: 1)
        let text = "Selamat!"
        var voices = ["after_break-word(1)", firstSyllable, secondSyllable]
        voices.append(contentsOf: ["after_break-word(2)", firstSyllable])
        voices.append(contentsOf: ["after_break-word(3)", secondSyllable])
        return Instruction(text: text, voices: voices)
    }
    
    static func cardActivityOpeningInstruction(_ syllable: Syllable) -> Instruction {
        let text = "Cari kartu yang sesuai dan tunjukkan ke kamera"
        let voices = ["before_card(1)", syllable.content,"before_card(2)"]
        return Instruction(text: text, voices: voices)
    }
    
    static func cardActivityClosingInstruction(_ syllable: Syllable) -> Instruction {
        let text = "Lihat hasil"
        let voices = ["after_card(1)"]
        return Instruction(text: text, voices: voices)
    }
    
    static func cardActivityResultInstruction(isCorrect: Bool) -> Instruction {
        let text = isCorrect ? "Selamat!" : "Coba lagi yuk!"
        let voices = isCorrect ? ["after_card(2-correct)"] : ["after_card(2-wrong)"]
        return Instruction(text: text, voices: voices)
    }
    
    static func pronunciationActivityOpeningInstruction(_ syllable: Syllable) -> Instruction {
        let voices = ["before_pronunciation", syllable.content]
        return Instruction(text: nil, voices: voices)
    }
    
    static func pronunciationActivityOpeningInstruction(_ word: Word) -> Instruction {
        var voices = ["before_pronunciation"]
        voices.append(contentsOf: word.syllables.compactMap { $0.content })
        return Instruction(text: nil, voices: voices)
    }
    
    static func pronunciationActivityClosingInstruction() -> Instruction {
        let voices = ["after_pronunciation(1)"]
        return Instruction(text: nil, voices: voices)
    }
    
    static func combineSyllablesActivityOpeningInstruction() -> Instruction {
        let text = "Gabungkan kedua suku kata"
        let voices = ["before_blend-word"]
        return Instruction(text: text, voices: voices)
    }
    
    static func combineSyllablesActivityClosingInstruction() -> Instruction {
        let text = "Selamat!"
        let voices = ["after_blend-word"]
        return Instruction(text: text, voices: voices)
    }
}

struct Instruction: Equatable {
    let text: String?
    let voices: [String]
}

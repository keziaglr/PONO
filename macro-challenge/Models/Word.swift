//
//  Word.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 23/10/23.
//

import Foundation

struct Word: Decodable, Equatable {
    let content: String
    let level: Int
    let syllables: [Syllable]
    
    func syllable(at index: Int) -> String {
        return syllables[safe: index]?.content ?? ""
    }
    
    static func == (lhs: Word, rhs: Word) -> Bool {
        lhs.content == rhs.content
    }
}

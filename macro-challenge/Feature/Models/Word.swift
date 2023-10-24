//
//  Word.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 23/10/23.
//

import Foundation

struct Word {
    let syllables: [Syllable]
    
    func formatted() -> String {
        syllables.reduce("") { $0 + $1.content }
    }
}

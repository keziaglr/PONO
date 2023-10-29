//
//  Syllable.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 23/10/23.
//

import Foundation

struct Syllable: Decodable {
    let id: UUID
    let content: String
    
    var letters: [String] {
        content.map { String($0) }
    }
}

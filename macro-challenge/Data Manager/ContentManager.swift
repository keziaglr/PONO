//
//  ContentManager.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 23/10/23.
//

import Foundation

class ContentManager {
    
    static let shared = ContentManager()
    
    private init() {}
    
    private var _syllables: [Syllable] = []
    
    var syllables: [Syllable] {
        if _syllables.isEmpty {
            _syllables = getSyllablesData()
        }
        return _syllables
    }
    
    private func getSyllablesData() -> [Syllable] {
        if let url = Bundle.main.url(forResource: "syllables", withExtension: "json") {
            do {
                let data =  try Data(contentsOf: url)
                return try JSONDecoder().decode([Syllable].self, from: data)
            } catch {
                return []
            }
        }
        return []
    }
}

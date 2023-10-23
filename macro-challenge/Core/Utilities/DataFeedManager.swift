//
//  DataFeedManager.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 23/10/23.
//

import Foundation

struct DataFeedManager {
    func createDataSyllables() -> [Syllable] {
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

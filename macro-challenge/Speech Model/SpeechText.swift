//
//  SpeechText.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 08/10/23.
//

import Foundation

struct SpeechText: Codable {
    var transcript: String?
    
    init(transcript: String? = nil) {
        self.transcript = transcript
    }
}

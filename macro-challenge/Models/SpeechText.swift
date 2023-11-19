//
//  SpeechText.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 17/11/23.
//

import Foundation

struct SpeechText: Codable {
    var transcript: String?
    
    init(transcript: String? = nil) {
        self.transcript = transcript
    }
}

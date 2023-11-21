//
//  RecordingButtonStyle.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 06/11/23.
//

import Foundation
import SwiftUI

enum PronunciationStatus {
    case idle
    case recording
    case correct
    case wrong
    
    var color: Color {
        switch self {
        case .idle:
            return .clear
        case .recording:
            return Color.Blue1
        case .correct:
            return Color.Green1
        case .wrong:
            return Color.Red2
        }
    }

    var images: String {
        switch self {
        case .idle:
            return "mic.slash.fill"
        case .recording:
            return "mic.fill"
        case .correct:
            return "checkmark"
        case .wrong:
            return "xmark"
        }
    }
    
    var colorAnimation: Color {
        switch self {
        case .idle:
            return .clear
        case .recording:
            return Color.Blue1.opacity(0.2)
        case .correct:
            return .clear
        case .wrong:
            return .clear
        }
    }
}



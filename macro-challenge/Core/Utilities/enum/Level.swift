//
//  Level.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 06/11/23.
//

import Foundation

enum Level{
    case easy, medium, hard
    
    func nextLevel() -> Level {
        switch self {
        case .easy:
            return .medium
        case .medium:
            return .hard
        case .hard:
            return .hard
        }
    }
}

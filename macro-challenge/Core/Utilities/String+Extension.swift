//
//  String+Extension.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 30/10/23.
//

import Foundation
import SwiftUI

extension String {
    func getCardVowelStyle() -> CardVowelStyleEnum {
        if let lastChar = self.last {
            switch lastChar {
            case "a":
                return CardVowelStyleEnum.A_VOWEL
            case "i":
                return CardVowelStyleEnum.I_VOWEL
            case "u":
                return CardVowelStyleEnum.U_VOWEL
            case "e":
                return CardVowelStyleEnum.E_VOWEL
            case "o":
                return CardVowelStyleEnum.O_VOWEL
            default:
                print("Vowel Doesn't Exist")
            }
        }
        return CardVowelStyleEnum.A_VOWEL
    }
    
    func getCardColor() -> Color {
        if let lastChar = self.last {
            switch lastChar {
            case "a":
                return Color.Red2
            case "i":
                return Color.Yellow2
            case "u":
                return Color.Green2
            case "e":
                return Color.Blue2
            case "o":
                return Color.Purple2
            default:
                print("Vowel Doesn't Exist")
            }
        }
        return Color.Red2
    }
}

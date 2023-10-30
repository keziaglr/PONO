//
//  String+Extension.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 30/10/23.
//

import Foundation

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
}

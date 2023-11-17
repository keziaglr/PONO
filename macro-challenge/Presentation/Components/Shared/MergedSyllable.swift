//
//  MergedSyllable.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 05/11/23.
//

import SwiftUI

struct MergedSyllable: View {
    
    var word: Word
    var syllableType: SyllableOrder
    
    var body: some View {
        HStack(spacing: -45) {
            BaseSyllableView(syllable: word.syllable(at: 0),
                             width: 195,
                             height: 98,
                             isLeftSide: true)
            .opacity(syllableType == .firstSyllable ? 1 : 0.3)
                
            
            BaseSyllableView(syllable: word.syllable(at: 1),
                             width: 195,
                             height: 98,
                             isLeftSide: false)
            .opacity(syllableType == .secondSyllable ? 1 : 0.3)
        }
    }
}

struct MergedSyllable_Previews: PreviewProvider {
    static var previews: some View {
        MergedSyllable(word: PreviewDataResources.word,
                       syllableType: .firstSyllable)
    }
}

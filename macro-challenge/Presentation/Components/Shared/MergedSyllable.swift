//
//  MergedSyllable.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 05/11/23.
//

import SwiftUI

struct MergedSyllable: View {
    var syllables: [Syllable]?
    var syllableType: TypeReading
    var body: some View {
        HStack(spacing: -45) {
            BaseSyllableView(syllable: syllables![0].content , width: 195, height: 98, isLeftSide: true).opacity(syllableType == .syllable1 ? 1 : 0.3)
                
            
            BaseSyllableView(syllable: syllables![1].content , width: 195, height: 98, isLeftSide: false).opacity(syllableType == .syllable2 ? 1 : 0.3)
        }
    }
}

struct MergedSyllable_Previews: PreviewProvider {
    static var previews: some View {
        MergedSyllable(syllables: [Syllable(id: UUID(), content: "ma", audioURL: nil, imageURL: nil),Syllable(id: UUID(), content: "mu", audioURL: nil, imageURL: nil)], syllableType: .syllable1)
    }
}

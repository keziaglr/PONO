//
//  PronounceInstruction.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 29/10/23.
//

import SwiftUI

struct PronounceInstruction: View {
    @State var syllable = "ba"
    var body: some View {
        
        HStack {
            Image(systemName: "speaker.wave.2.fill")
                .resizable()
                .frame(width: 29, height: 22)
                .foregroundStyle(.blue)
            
            Text(syllable)
                .font(
                    .custom(FontConst.QUICKSAND_BOLD, size: 40)
                )
        }
        .padding(.horizontal, 20)
        .frame(height: 100)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .shadow(color: .gray, radius: 1, y: 2)
        )
    }
}

#Preview {
    PronounceInstruction(syllable: "bu")
}

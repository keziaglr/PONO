//
//  ReadingActivity.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 26/10/23.
//

import SwiftUI

struct ReadingSyllables: View {
    
    @State private var syllable = "ma"
    

    
    var body: some View {
        VStack {
            Spacer()
            
            // Play record component
            HStack {
                
                Spacer()
                    .frame(width: 30)
                
                
                PronounceInstruction(syllable: "bu")
                
            }
            
            
            Spacer()
            
            Image(systemName: "mic.fill")
                .resizable()
                .frame(width: 47, height: 66)
                .foregroundStyle(.gray)
                .offset(y: -20)
            
        }
    }
    

}

#Preview {
    ReadingSyllables()
}

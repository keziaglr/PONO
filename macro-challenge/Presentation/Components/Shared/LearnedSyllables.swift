//
//  LearnedSyllables.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 16/11/23.
//

import SwiftUI

struct LearnedSyllables: View {
//    @State private var syllables =  ["ma", "mi", "mu", "me", "mo", "pa", "pi", "pu", "pe", "po", "la", "li"]
    
    @ObservedObject private var viewModel = ReportViewModel()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Suku kata yang dipelajari")
                    .textCase(.uppercase)
                    .font(.custom("Quicksand-Bold", size: 14))
                    .padding(.horizontal)
                Text("\(viewModel.syllables.count) dari 35 suku kata")
                    .font(.custom("Quicksand", size: 12))
                    .padding(.horizontal)
                ScrollView {
                    
                    Section {
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)], spacing: 40) {
                            ForEach(viewModel.syllables, id: \.self) { syllable in
                                VStack {
                                    FrontCardWordSyllableLabel(syllable: syllable)
                                }
                                
                            }
                        }
                        .padding()
                    }
                    
                }
            }
            
        }
        .padding()
        .frame(maxWidth: 590, maxHeight: .infinity)
        .background(.white)
        .cornerRadius(30)
    }
}


//#Preview {
//    LearnedSyllables(syllables: ["ma", "mi", "mu", "me", "mo", "pa", "pi", "pu", "pe", "po", "la", "li"], learnedSyllable: 30)
//}

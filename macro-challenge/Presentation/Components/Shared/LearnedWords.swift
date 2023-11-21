//
//  LearnedWords.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 16/11/23.
//

import SwiftUI

struct LearnedWords: View {
//    @State private var words =  ["mami", "papi", "buku", "beta", "buta", "buka", "babi", "duda", "babu", "Kuku", "kaki"]
    
    @State var words : [String]
    @State private var isFlipped: Bool = false

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Kata yang dipelajari")
                    .textCase(.uppercase)
                    .font(.custom("Quicksand-Bold", size: 14))
                    .padding(.horizontal)
                Text("34 dari 111 kata")
                    .font(.custom("Quicksand", size: 12))
                    .padding(.horizontal)
                ScrollView {
                    Section {
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)], spacing: 40) {
                            ForEach(words, id: \.self) { word in
                                VStack{
//                                    if isFlipped {
//                                        BackCardWordSyllableLabel(isSyllable: false, isUnderAverage: false, cardPercentage: 60, speechPercentage: 50)
//                                    } else {
//                                        FrontCardWordSyllableLabel(text: word, learnedType: "word")
//                                    }
                                    FrontCardWordSyllableLabel(text: word, learnedType: "word", condition: "underAverage", isWord: true, rating: 3)
                                    
                                }
                                .onTapGesture {
                                    withAnimation {
                                        isFlipped.toggle()
                                    }
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

#Preview {
    LearnedWords(words: ["papi", "mami", "babi", "budi", "dada", "baba", "baku"])
}

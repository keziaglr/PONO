//
//  LearnedWords.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 16/11/23.
//

import SwiftUI

struct LearnedWords: View {
//    @State private var words =  ["mami", "papi", "buku", "beta", "buta", "buka", "babi", "duda", "babu", "Kuku", "kaki"]
    
    @State var words : [PracticedWord] = []
    @State private var isFlipped: Bool = false
    @ObservedObject var viewModel = ReportViewModel()

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Kata yang sudah dipelajari")
                    .textCase(.uppercase)
                    .font(.custom("Quicksand-Bold", size: 14))
                    .padding(.horizontal)
                    .padding(.top, 15)
                Text("\(viewModel.words.count) dari 111 kata")
                    .font(.custom("Quicksand", size: 12))
                    .padding(.horizontal)
                ScrollView {
                    Section {
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)], spacing: 40) {
                            ForEach(viewModel.words, id: \.self) { word in
                                VStack{
                                    FrontCardWordSyllableLabel(word: word)
                                    
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

//#Preview {
//    LearnedWords(words: ["papi", "mami", "babi", "budi", "dada", "baba", "baku"], learnedWord: 30)
//}

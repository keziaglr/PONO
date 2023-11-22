//
//  ReportActivity.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 16/11/23.
//

import SwiftUI

struct ReportScreenView: View {
    @ObservedObject private var viewModel = ReportViewModel()
    
    @State private var total = 20

    var body: some View {
        ZStack {
            Image("Cloud")
                .resizable()
                .scaledToFit()
            
                VStack {
                    Text("Laporan Mingguan")
                        .font(.custom("Quicksand-Bold", size: 40))
                        .foregroundStyle(Color.White1)
                    if viewModel.practices.isEmpty {
                        VStack {
                            NoSessionStartedView()
                        }
                        .frame(maxHeight: .infinity)
                    } else {
                    HStack(spacing: 24) {
                        ForEach(viewModel.buttonData, id: \.title) { buttonData in
                            let total = /*viewModel.fetchTotal(for: buttonData.component)*/
                            total
                            ReportNavigation(title: buttonData.title, iconName: buttonData.iconName, total: total, isSelected: viewModel.selectedComponent == buttonData.component, action: {
                                viewModel.changeSelectedComponent(to: buttonData.component)
                            })
                        }
                        
                        
                        
                    }
                    .padding(.bottom, 20)

                        
                    TabView(selection: $viewModel.selectedComponent) {
                        // Session Content
                        
                        ChartView()
                            .tag(SelectedComponent.session)
                        
                        // Word data
                        LearnedWords(words: ["papi", "mami", "babi", "budi", "dada", "baba", "baku"], learnedWord: 30)
                            .tag(SelectedComponent.word)
                        
                        // Syllable Data
                        LearnedSyllables(syllables: ["ma", "mi", "mu", "me", "mo", "pa", "pi", "pu", "pe", "po", "la", "li"], learnedSyllable: 30)
                            .tag(SelectedComponent.syllable)
                        
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                }
            }

        }
        .background(Color.Blue3)
    }
}

#Preview {
    ReportScreenView()
}

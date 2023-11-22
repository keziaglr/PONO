//
//  ReportActivity.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 16/11/23.
//

import SwiftUI

struct ReportScreenView: View {
    @ObservedObject private var viewModel = ReportViewModel()
    @Environment(\.switchableNavigate) var switchableNavigate
    
    @State private var total = 20

    var body: some View {
        ZStack {
            Image("Cloud")
                .resizable()
                .scaledToFit()
            VStack {
                HStack {
                    Button {
                        switchableNavigate(.home)
                    } label: {
                        Image(systemName: "house.fill")
                    }.buttonStyle(PonoButtonStyle(variant: .tertiary))
                    Spacer()
                }
                Spacer()
            }
            .padding()
            
            
                VStack {
                    Text("Laporan Hasil Belajar")
                        .font(.system(size: 40, design: .rounded))
                        .fontWeight(.black)
                        .foregroundStyle(Color.Yellow2)
                        .tracking(5.0)
                        .glowBorder(color: Color.White2, lineWidth: 16)
                        .padding(.top, 20)
                        .padding()

                    if viewModel.practices.isEmpty {
                        VStack {
                            NoSessionStartedView(startExercise: {switchableNavigate(.learningActivity)})
                        }
                        .frame(maxHeight: .infinity)
                    } else {
                        
                    HStack(spacing: 24) {
                        ReportNavigation(title: viewModel.buttonData[0].title, iconName: viewModel.buttonData[0].iconName, total: viewModel.fetchPracticesTotal(), isSelected: viewModel.selectedComponent == viewModel.buttonData[0].component, action: {
                                viewModel.changeSelectedComponent(to: viewModel.buttonData[0].component)
                            })
                            ReportNavigation(title: viewModel.buttonData[1].title, iconName: viewModel.buttonData[1].iconName, total: viewModel.fetchSyllablesTotal(), isSelected: viewModel.selectedComponent == viewModel.buttonData[1].component, action: {
                                viewModel.changeSelectedComponent(to: viewModel.buttonData[1].component)
                            })
                            ReportNavigation(title: viewModel.buttonData[2].title, iconName: viewModel.buttonData[2].iconName, total: viewModel.fetchWordsTotal(), isSelected: viewModel.selectedComponent == viewModel.buttonData[2].component, action: {
                                viewModel.changeSelectedComponent(to: viewModel.buttonData[2].component)
                            })
                    }
                    .padding(.bottom, 20)

                        
                    TabView(selection: $viewModel.selectedComponent) {
                        // Session Content
                        
                        ChartView()
                            .tag(SelectedComponent.session)
                        
                        // Word data
                        LearnedWords()
                            .tag(SelectedComponent.word)
                        
                        // Syllable Data
                        LearnedSyllables()
                            .tag(SelectedComponent.syllable)
                        
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                }
            }

        }
        .background(Color.Blue3)
    }
}

//#Preview {
//    ReportScreenView()
//}

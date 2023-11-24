//
//  EndStageActivityView.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 21/11/23.
//

import SwiftUI

struct EndStageActivityView: View {
    @ObservedObject private var viewModel: EndStageActivityViewModel
    @State private var buttonTapped = false
    let onNext: () -> Void
    let backHome: () -> Void
    
    init(learningWord: Word, onNext: @escaping () -> Void, backHome: @escaping () -> Void) {
        self.viewModel = EndStageActivityViewModel(learningWord: learningWord)
        self.onNext = onNext
        self.backHome = backHome
    }
    
    var body: some View {
        ZStack {
            Congratulation(word: viewModel.learningWord)
                .cornerRadius(40)
            
            VStack {
                Spacer()
                HStack {
                    Button {
                        buttonTapped.toggle()
                        onNext()
                    } label: {
                        Image(systemName: "arrow.right")
                    }
                    .buttonStyle(PonoButtonStyle(variant: .primary))
                    .disabled(buttonTapped)
                    
                    Button {
                        backHome()
                    } label: {
                        Image(systemName: "house.fill")
                    }
                    .buttonStyle(PonoButtonStyle(variant: .tertiary))
                    
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
        }.onAppear {
            viewModel.playInstruction()
        }
    }
}

//struct EndStageActivityView_Previews: PreviewProvider {
//    static var previews: some View {
//        EndStageActivityView(learnedWord: Word(content: "mami", level: 3, syllables: [Syllable(id: UUID(), content: "ma"), Syllable(id: UUID(), content: "mi")]), onNext: {}, backHome: {})
//    }
//}

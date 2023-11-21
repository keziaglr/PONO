//
//  EndStageActivityView.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 21/11/23.
//

import SwiftUI

struct EndStageActivityView: View {
    @ObservedObject private var viewModel: EndStageActivityViewModel
    let onNext: () -> Void
    let backHome: () -> Void
    
    init(learningWord: Word, onNext: @escaping () -> Void, backHome: @escaping () -> Void) {
        self.viewModel = EndStageActivityViewModel(learningWord: learningWord)
        self.onNext = onNext
        self.backHome = backHome
    }
    
    var body: some View {
        VStack {
            Spacer()
            Congratulation(word: viewModel.learningWord)
                .cornerRadius(40)
            Spacer()
            HStack {
                Button {
                    onNext()
                } label: {
                    Image(systemName: "arrow.right")
                }
                .buttonStyle(PonoButtonStyle(variant: .primary))
                
                Button {
                    backHome()
                } label: {
                    Image(systemName: "house.fill")
                }
                .buttonStyle(PonoButtonStyle(variant: .tertiary))
                
            }
            .padding(20)
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

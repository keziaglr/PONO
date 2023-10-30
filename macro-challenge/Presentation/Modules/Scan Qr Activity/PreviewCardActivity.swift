//
//  PreviewCardActivity.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 30/10/23.
//

import SwiftUI

struct PreviewCardActivity: View {
    @ObservedObject var viewModel : FlowScreenViewModel
    @State private var isFlipped = true
    var isCardChecked = true
    var syllable: String = ""
    var cardVowelStyle: CardVowelStyleEnum = .A_VOWEL
    var body: some View {
        HStack {
            FrontCardView(syllable: syllable, cardVowelStyle: cardVowelStyle)
            ZStack {
                if isFlipped {
                    if viewModel.type == .syllable1 {
                        BackCardView(cardVowelStyle: (viewModel.word?.syllables.first!.content)!.getCardVowelStyle())
                    } else {
                        BackCardView(cardVowelStyle: (viewModel.word?.syllables[1].content)!.getCardVowelStyle())
                    }
                } else {
                    if viewModel.type == .syllable1 {
                        FrontCardView(syllable: viewModel.word?.syllables.first?.content ?? "A", cardVowelStyle: viewModel.word?.syllables.first?.content.getCardVowelStyle() ?? CardVowelStyleEnum.A_VOWEL, showFrameBordered: false)
                    } else {
                        FrontCardView(syllable: viewModel.word?.syllables[1].content ?? "A", cardVowelStyle: viewModel.word?.syllables[1].content.getCardVowelStyle() ?? CardVowelStyleEnum.A_VOWEL, showFrameBordered: false)
                    }
                    
                }
            }.onReceive(viewModel.$isCardFlipped) { newValue in
                print("NEWWWW \(newValue)")
                withAnimation {
                    isFlipped.toggle()
                }
            }.padding(.leading, 20)
        }.onAppear {
            if isCardChecked {
                isFlipped = false
            } else {
                isFlipped = true
            }
            viewModel.getInstruction()
            viewModel.playInstruction()
        }
    }
}

struct PreviewCardActivity_Previews: PreviewProvider {
    static var previews: some View {
        PreviewCardActivity(viewModel: FlowScreenViewModel(), isCardChecked: false , syllable: "ma", cardVowelStyle: .A_VOWEL)
    }
}

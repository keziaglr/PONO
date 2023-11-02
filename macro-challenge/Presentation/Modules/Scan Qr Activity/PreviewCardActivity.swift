//
//  PreviewCardActivity.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 30/10/23.
//

import SwiftUI

struct PreviewCardActivity: View, ActivityViewProtocol {
    var next: () -> Void
    
    @ObservedObject var viewModel : FlowScreenViewModel
    @State private var isFlipped = true
    var isCardChecked = true
    var syllable: String = ""
    var cardVowelStyle: CardVowelStyleEnum = .A_VOWEL
    var body: some View {
        ZStack {
            VStack{
                Spacer()
                    HStack {
                        Button {
                            next()
                        } label: {
                            Image(systemName: "arrow.right")
                                .font(Font.system(size: 50, weight: .bold))
                                .foregroundStyle(Color.White1)
                                .padding()
                        }
                        .buttonStyle(PonoButtonStyle(variant: .primary))
                        
                        if viewModel.activity == .correctCard || viewModel.activity == .wrongCard{
                            Button{
                                viewModel.tryAgain()
                            }label: {
                                Image(systemName: "arrow.counterclockwise")
                                    .font(Font.system(size: 40, weight: .bold))
                                    .foregroundStyle(Color.Blue1)
                                    .padding()
                            }.buttonStyle(PonoButtonStyle(variant: .secondary))
                        }
                        
                    }.padding(.horizontal, 20)
            }
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
}

struct PreviewCardActivity_Previews: PreviewProvider {
    static var previews: some View {
        PreviewCardActivity(next: {}, viewModel: FlowScreenViewModel(), isCardChecked: false , syllable: "ma", cardVowelStyle: .A_VOWEL)
            .background(Color.Blue4)
    }
}

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
    
    private let durationAndDelay : CGFloat = 0.2
    
    @State private var backDegree = 0.0
    @State private var frontDegree = -90.0
    
    var body: some View {
        ZStack {
            VStack{
                Spacer()
                    HStack {
                        Button {
                            next()
                        } label: {
                            Image(systemName: "arrow.right")
                        }
                        .buttonStyle(PonoButtonStyle(variant: .primary))
                        
                        if viewModel.activity == .wrongCard{
                            Button{
                                viewModel.tryAgain()
                            }label: {
                                Image(systemName: "arrow.counterclockwise")
                            }.buttonStyle(PonoButtonStyle(variant: .tertiary))
                        }
                        
                    }.padding(20)
            }
            HStack {
                ZStack {
                    if viewModel.type == .syllable1 {
                        BackCardView(cardVowelStyle: (viewModel.word?.syllables.first!.content)!.getCardVowelStyle(), degree: $backDegree)
                    } else {
                        BackCardView(cardVowelStyle: (viewModel.word?.syllables[1].content)!.getCardVowelStyle(), degree: $backDegree)
                    }
                    if viewModel.type == .syllable1 {
                        FrontCardView(syllable: viewModel.word?.syllables.first?.content ?? "A", cardVowelStyle: viewModel.word?.syllables.first?.content.getCardVowelStyle() ?? CardVowelStyleEnum.A_VOWEL, showFrameBordered: false, degree: $frontDegree)
                    } else {
                        FrontCardView(syllable: viewModel.word?.syllables[1].content ?? "A", cardVowelStyle: viewModel.word?.syllables[1].content.getCardVowelStyle() ?? CardVowelStyleEnum.A_VOWEL, showFrameBordered: false, degree: $frontDegree)
                    }
                }.onReceive(viewModel.$isCardFlipped) { newValue in
                    if !newValue {
                        flipCard()
                    }
                }.padding(.leading, 20)
                Spacer().frame(width: 100)
                FrontCardView(syllable: syllable, cardVowelStyle: cardVowelStyle, degree: .constant(0))
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
    
    func flipCard() {
        isFlipped.toggle()
        if !isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
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

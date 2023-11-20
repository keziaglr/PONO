//
//  PreviewCardView.swift
//  macro-challenge
//
//  Created by Rio Johanes Sumolang on 16/11/23.
//

import SwiftUI

struct PreviewCardView: View {
    @ObservedObject var viewModel: CardActivityViewModel
    var scannedCard: Syllable
    let onNext: () -> Void
    let onRetry: () -> Void
    @State private var isFlipped = true
    @State private var backDegree = 0.0
    @State private var frontDegree = -90.0
    private let durationAndDelay : CGFloat = 0.2
    var isCardChecked = true
    var syllable: Syllable
    
    var body: some View {
        ZStack {
            VStack{
                Spacer()
                HStack {
                    Button {
                        if !isFlipped {
                            onNext()
                        } else {
                            flipCard()
                        }
                    } label: {
                        Image(systemName: "arrow.right")
                    }
                    .buttonStyle(PonoButtonStyle(variant: .primary))
                    
                    Button{
                        onRetry()
                    }label: {
                        Image(systemName: "arrow.counterclockwise")
                    }
                    .buttonStyle(PonoButtonStyle(variant: .tertiary))
                    
                }
                .padding(20)
            }
            HStack {
                ZStack {
                    BackCardView(cardVowelStyle: scannedCard.letters.last!.getCardVowelStyle(), degree: $backDegree)
                    FrontCardView(syllable: scannedCard.content , cardVowelStyle: scannedCard.letters.last!.getCardVowelStyle() , showFrameBordered: false, degree: $frontDegree)
                }
                Spacer().frame(width: 100)
                FrontCardView(syllable: syllable.content, cardVowelStyle: syllable.letters.last!.getCardVowelStyle(), degree: .constant(0))
            }.padding(.leading, 20)
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

//#Preview {
//    PreviewCardView(viewModel: RefactoringCardActivityViewModel(learningWord: Word(content: "Makan", level: 1, syllables: []), syllableOrder: .firstSyllable), scannedCard: Syllable(id: UUID(), content: "AA") , onNext: {}, onRetry: {}, syllable: Syllable(id: UUID(), content: "Mu"))
//}

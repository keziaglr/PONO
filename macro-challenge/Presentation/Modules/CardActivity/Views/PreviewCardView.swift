//
//  PreviewCardView.swift
//  macro-challenge
//
//  Created by Rio Johanes Sumolang on 16/11/23.
//

import SwiftUI

struct PreviewCardView: View {
    let onNext: () -> Void
    let onRetry: () -> Void
    @State private var isFlipped = true
    var isCardChecked = true
    var syllable: Syllable
    var cardVowelStyle: CardVowelStyleEnum = .A_VOWEL
    
    var body: some View {
        ZStack {
            VStack{
                Spacer()
                HStack {
                    Button {
                        onNext()
                    } label: {
                        Image(systemName: "arrow.right")
                    }
                    .buttonStyle(PonoButtonStyle(variant: .primary))
                    
                    Button{
                        onRetry()
                    }label: {
                        Image(systemName: "arrow.counterclockwise")
                    }.buttonStyle(PonoButtonStyle(variant: .tertiary))
                    
                }
                .padding(20)
            }
            HStack {
                ZStack {
                    if isFlipped {
                        BackCardView(cardVowelStyle: syllable.letters[1].getCardVowelStyle())
                    } else {
                        FrontCardView(syllable: syllable.letters[1] ?? "A", cardVowelStyle: syllable.letters[1].getCardVowelStyle() ?? CardVowelStyleEnum.A_VOWEL, showFrameBordered: false)
                    }
                }
//                .onReceive(isFlipped) { newValue in
//                    withAnimation {
//                        isFlipped.toggle()
//                    }
                }.padding(.leading, 20)
                Spacer().frame(width: 100)
                
//                FrontCardView(syllable: syllable, cardVowelStyle: cardVowelStyle)
            }.onAppear {
                if isCardChecked {
                    isFlipped = false
                } else {
                    isFlipped = true
                }
            }
        }
    }
//}

//#Preview {
//    PreviewCardView(onNext: {}, onRetry: {}, syllable: Syllable(id: "", content: ""))
//}

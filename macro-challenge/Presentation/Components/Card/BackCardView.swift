//
//  BackCardView.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 26/10/23.
//

import SwiftUI

struct BackCardView: View {
    var cardVowelStyle: CardVowelStyleEnum

    private var ponoColor = ""
    
    init(
        cardVowelStyle: CardVowelStyleEnum
    ) {
        self.cardVowelStyle = cardVowelStyle
        setupValue()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 24)
                            .fill(Color.white)
                            .frame(width: 170, height: 255)
                            .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 10)
                        
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black)
                    .frame(width: 146, height: 231)
                RoundedRectangle(cornerRadius: 0)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .clipShape(CustomShape(cornerRadius: 20, corners: [.bottomRight]))
                Image("barcode")
                    .resizable()
                    .frame(width: 35, height: 35)

            }.padding(.bottom, 10)

            
        Image(ponoColor)
            .resizable()
            .frame(width: 48, height: 125)
            .padding(.bottom, 26)
            
        }
    }
    
    mutating func setupValue() {
        switch cardVowelStyle {
        case .A_VOWEL:
            self.ponoColor = ImageConst.IV_PONO_CARD_RED
        case .I_VOWEL:
            self.ponoColor = ImageConst.IV_PONO_CARD_DEAD_YELLOW
        case .U_VOWEL:
            self.ponoColor = ImageConst.IV_PONO_CARD_GREEN
        case .E_VOWEL:
            self.ponoColor = ImageConst.IV_PONO_CARD_BLUE
        case .O_VOWEL:
            self.ponoColor = ImageConst.IV_PONO_CARD_PURPLE
        }
    }
}

struct BackCardView_Previews: PreviewProvider {
    static var previews: some View {
        BackCardView(cardVowelStyle: CardVowelStyleEnum.O_VOWEL)
    }
}

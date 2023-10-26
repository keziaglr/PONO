//
//  BackCardView.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 26/10/23.
//

import SwiftUI

struct BackCardView: View {
    var cardVowelStyle: CardVowelStyleEnum
    
    private var backgroundCardColor = ""
    
    init(
        cardVowelStyle: CardVowelStyleEnum
    ) {
        self.cardVowelStyle = cardVowelStyle
        setupValue()
    }
    
    var body: some View {
        VStack {
            Image(ImageConst.CARD_BACK_FRAME_TOP)
                .padding(EdgeInsets(top: 7, leading: 0, bottom: 0, trailing: 0))
            Spacer()
            Text("App Name")
                .font(.custom(FontConst.QUICKSAND_SEMI_BOLD,size: 12))
                .foregroundColor(Color.white)
            Spacer()
            Image(ImageConst.QR_CODE_DUMMY)
            Spacer()
            Text("App Name")
                .font(.custom(FontConst.QUICKSAND_SEMI_BOLD,size: 12))
                .foregroundColor(Color.white)
            Spacer()
            Image(ImageConst.CARD_BACK_FRAME_BOTTOM)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 7, trailing: 0))
        }.frame(width: 170, height: 255)
            .background(Color(hex: backgroundCardColor))
            .cornerRadius(20)
    }
    
    mutating func setupValue() {
        switch cardVowelStyle {
        case .A_VOWEL:
            self.backgroundCardColor = ColorConst.TEXT_CARD_RED
        case .I_VOWEL:
            self.backgroundCardColor = ColorConst.TEXT_CARD_DEAD_YELLOW
        case .U_VOWEL:
            self.backgroundCardColor = ColorConst.TEXT_CARD_GREEN
        case .E_VOWEL:
            self.backgroundCardColor = ColorConst.TEXT_CARD_BLUE
        case .O_VOWEL:
            self.backgroundCardColor = ColorConst.TEXT_CARD_PURPLE
        }
    }
}

struct BackCardView_Previews: PreviewProvider {
    static var previews: some View {
        BackCardView(cardVowelStyle: CardVowelStyleEnum.O_VOWEL)
    }
}

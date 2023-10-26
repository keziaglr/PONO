//
//  CardView.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 26/10/23.
//

import SwiftUI

struct FrontCardView: View {
    var syllable: String
    var cardVowelStyle: CardVowelStyleEnum
    
    private var textColor = ""
    private var backgroundColor = ""
    private var cover_top_img = ""
    private var cover_bottom_img = ""
    
    init(
        syllable: String,
        cardVowelStyle: CardVowelStyleEnum
    ) {
        self.syllable = syllable
        self.cardVowelStyle = cardVowelStyle
        setupValue()
    }
    
    var body: some View {
        VStack {
            Image(cover_top_img)
            Spacer()
            Text(syllable)
                .font(
                    .custom(FontConst.QUICKSAND_BOLD, size: 75)
                ).foregroundColor(Color(hex: textColor))
            Spacer()
            Image(cover_bottom_img)
        }.frame(width: 170, height: 255)
            .background(Color(hex: backgroundColor))
            .cornerRadius(20)
    }
    
    mutating func setupValue() {
        switch cardVowelStyle {
        case .A_VOWEL:
            self.backgroundColor = ColorConst.BACKGROUND_CARD_RED
            self.textColor = ColorConst.TEXT_CARD_RED
            self.cover_top_img = ImageConst.CARD_FRAME_TOP_RED
            self.cover_bottom_img = ImageConst.CARD_FRAME_BOTTOM_RED
        case .I_VOWEL:
            self.backgroundColor = ColorConst.BACKGROUND_CARD_DEAD_YELLOW
            self.textColor = ColorConst.TEXT_CARD_DEAD_YELLOW
            self.cover_top_img = ImageConst.CARD_FRAME_TOP_DEAD_YELLOW
            self.cover_bottom_img = ImageConst.CARD_FRAME_BOTTOM_DEAD_YELLOW
        case .U_VOWEL:
            self.backgroundColor = ColorConst.BACKGROUND_CARD_GREEN
            self.textColor = ColorConst.TEXT_CARD_GREEN
            self.cover_top_img = ImageConst.CARD_FRAME_TOP_GREEN
            self.cover_bottom_img = ImageConst.CARD_FRAME_BOTTOM_GREEN
        case .E_VOWEL:
            self.backgroundColor = ColorConst.BACKGROUND_CARD_BLUE
            self.textColor = ColorConst.TEXT_CARD_BLUE
            self.cover_top_img = ImageConst.CARD_FRAME_TOP_BLUE
            self.cover_bottom_img = ImageConst.CARD_FRAME_BOTTOM_BLUE
        case .O_VOWEL:
            self.backgroundColor = ColorConst.BACKGROUND_CARD_PURPLE
            self.textColor = ColorConst.TEXT_CARD_PURPLE
            self.cover_top_img = ImageConst.CARD_FRAME_TOP_PURPLE
            self.cover_bottom_img = ImageConst.CARD_FRAME_BOTTOM_PURPLE
        }
    }
}

struct FrontCardView_Previews: PreviewProvider {
    static var previews: some View {
        FrontCardView(syllable: "mu", cardVowelStyle: CardVowelStyleEnum.O_VOWEL)
    }
}

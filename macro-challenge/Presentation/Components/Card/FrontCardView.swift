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
    var showFrameBordered = true
    
    private var textColor = ""
    private var backgroundColor = ""
    private var cover_top_img = ""
    private var cover_bottom_img = ""
    
    init(
        syllable: String,
        cardVowelStyle: CardVowelStyleEnum,
        showFrameBordered: Bool = true
    ) {
        self.syllable = syllable
        self.cardVowelStyle = cardVowelStyle
        self.showFrameBordered = showFrameBordered
        setupValue()
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                            .fill(Color.white)
                            .frame(width: 170, height: 255)
                            .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 10)
                        
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(hex: backgroundColor))
                    .frame(width: 146, height: 231)
                RoundedRectangle(cornerRadius: 0)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .clipShape(CustomShape(cornerRadius: 20, corners: [.bottomRight]))
                Image(cover_top_img)
                    .frame(width: 32, height: 32)
            }
            
            if showFrameBordered {
//                Image("bg_card_frame_bordered")
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.Grey1,
                        style: StrokeStyle(lineWidth: 3, dash: [20]))
                    .frame(width: 185, height: 270)
            }
            Text(syllable)
                .font(
                    .custom(FontConst.QUICKSAND_BOLD, size: 75)
                ).foregroundColor(Color.white)
        }
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
        FrontCardView(syllable: "mu", cardVowelStyle: CardVowelStyleEnum.A_VOWEL)
    }
}

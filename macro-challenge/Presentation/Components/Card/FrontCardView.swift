//
//  CardView.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 26/10/23.
//

import SwiftUI

struct FrontCardView: View {
    var syllable: Syllable
    var cardVowelStyle: CardVowelStyleEnum
    var showFrameBordered = true
    
    private var backgroundColor = Color.white
    private var cover_top_img = ""
    private var cover_bottom_img = ""
    @Binding var degree : Double
    
    init(
        syllable: Syllable,
        cardVowelStyle: CardVowelStyleEnum,
        showFrameBordered: Bool = true,
        degree: Binding<Double>
    ) {
        self.syllable = syllable
        self.cardVowelStyle = cardVowelStyle
        self.showFrameBordered = showFrameBordered
        self._degree = degree
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
                    .fill(backgroundColor)
                    .frame(width: 146, height: 231)
                RoundedRectangle(cornerRadius: 0)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .clipShape(CustomShape(cornerRadius: 20, corners: [.bottomRight]))
                Image(cover_top_img)
                    .frame(width: 32, height: 32)
            }
            
            if showFrameBordered {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white,
                        style: StrokeStyle(lineWidth: 3, dash: [20]))
                    .frame(width: 185, height: 270)
            }
            Text(syllable.content)
                .font(
                    .custom(FontConst.QUICKSAND_BOLD, size: 75)
                ).foregroundColor(Color.white)
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
    
    mutating func setupValue() {
        switch cardVowelStyle {
        case .A_VOWEL:
            self.backgroundColor = Color.Red2
            self.cover_top_img = ImageConst.CARD_FRAME_TOP_RED
            self.cover_bottom_img = ImageConst.CARD_FRAME_BOTTOM_RED
        case .I_VOWEL:
            self.backgroundColor = Color.Yellow2
            self.cover_top_img = ImageConst.CARD_FRAME_TOP_DEAD_YELLOW
            self.cover_bottom_img = ImageConst.CARD_FRAME_BOTTOM_DEAD_YELLOW
        case .U_VOWEL:
            self.backgroundColor = Color.Green2
            self.cover_top_img = ImageConst.CARD_FRAME_TOP_GREEN
            self.cover_bottom_img = ImageConst.CARD_FRAME_BOTTOM_GREEN
        case .E_VOWEL:
            self.backgroundColor = Color.Blue2
            self.cover_top_img = ImageConst.CARD_FRAME_TOP_BLUE
            self.cover_bottom_img = ImageConst.CARD_FRAME_BOTTOM_BLUE
        case .O_VOWEL:
            self.backgroundColor = Color.Purple2
            self.cover_top_img = ImageConst.CARD_FRAME_TOP_PURPLE
            self.cover_bottom_img = ImageConst.CARD_FRAME_BOTTOM_PURPLE
        }
    }
}

//struct FrontCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        FrontCardView(syllable: "bu", cardVowelStyle: CardVowelStyleEnum.A_VOWEL, degree: <#Binding<Double>#>)
//    }
//}

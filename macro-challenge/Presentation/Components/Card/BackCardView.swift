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
        ZStack {
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
            }
            
        }
//        VStack {
//            Image(ImageConst.CARD_BACK_FRAME_TOP)
//                .padding(EdgeInsets(top: 7, leading: 0, bottom: 0, trailing: 0))
//            Spacer()
//            Text("App Name")
//                .font(.custom(FontConst.QUICKSAND_SEMI_BOLD,size: 12))
//                .foregroundColor(Color.white)
//            Spacer()
//            Image(ImageConst.QR_CODE_DUMMY)
//            Spacer()
//            Text("App Name")
//                .font(.custom(FontConst.QUICKSAND_SEMI_BOLD,size: 12))
//                .foregroundColor(Color.white)
//            Spacer()
//            Image(ImageConst.CARD_BACK_FRAME_BOTTOM)
//                .padding(EdgeInsets(top: 0, leading: 0, bottom: 7, trailing: 0))
//        }.frame(width: 170, height: 255)
//            .background(Color(hex: backgroundCardColor))
//            .cornerRadius(20)
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

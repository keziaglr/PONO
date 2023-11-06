//
//  BaseSyllableView.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 05/11/23.
//

import SwiftUI

struct BaseSyllableView: View {
    var syllable: String
    var width: CGFloat
    var height: CGFloat
    var isLeftSide: Bool
    var body: some View {
        ZStack {
            Image(isLeftSide ? "left" : "right")
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height)
                .shadow(color: Color.Blue1.opacity(0.15),radius: 20, y: 8)
            Text(syllable)
                .font(.custom("Quicksand-Bold", size: 30))
                .foregroundColor(syllable.getCardColor())
                .kerning(10)
                .padding(.horizontal, 50)
                .frame(width: width, height: height)
        }
    }
}

struct BaseSyllableView_Previews: PreviewProvider {
    static var previews: some View {
        BaseSyllableView(syllable: "mo", width: 195, height: 98, isLeftSide: true)
    }
}

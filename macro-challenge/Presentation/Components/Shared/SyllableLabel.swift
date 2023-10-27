//
//  SyllableLabel.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 23/10/23.
//

import SwiftUI

struct SyllableLabel: View {
    @State var syllable : String
    @State var height: CGFloat
    @State var width: CGFloat
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            Text(syllable)
//                .textStyle(style: .heading1)
                .font(.custom("Quicksand-Bold", size: 100))
                .foregroundColor(Color.Blue1)
                .kerning(25)
                .padding(.horizontal, 50)
        }.background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.Blue3)
                .frame(width: width, height: height)
                .opacity(show ? 1 : 0)
        )
    }
}

struct SyllableLabel_Previews: PreviewProvider {
    static var previews: some View {
        SyllableLabel(syllable: "bu", height: 200, width: 300, show: .constant(true))
    }
}

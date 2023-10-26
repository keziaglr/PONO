//
//  SyllableLabel.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 23/10/23.
//

import SwiftUI

struct SyllableLabel: View {
    @State var position : String
    @State var syllable : String
    @State var height: CGFloat
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            Image(position)
                .resizable()
                .scaledToFit()
                .frame(height: height)
                .opacity(show ? 1 : 0)
            Text(syllable)
//                .textStyle(style: .heading1)
                .font(.custom("Quicksand-Bold", size: 140))
                .kerning(25)
        }
    }
}

struct SyllableLabel_Previews: PreviewProvider {
    static var previews: some View {
        SyllableLabel(position: "left", syllable: "bu", height: 200, show: .constant(true))
    }
}

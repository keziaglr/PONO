//
//  SyllableLabel.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 23/10/23.
//

import SwiftUI

struct SyllableLabel: View {
    @State var left : Bool
    @Binding var scale: Bool
    @State var syllable : String
    @State var height: CGFloat
    @State var width: CGFloat
    @Binding var show: Bool
    @State var textColor: Color = Color.Grey1
    
    var body: some View {
        ZStack {
            Text(syllable)
                .font(.custom("Quicksand-Bold", size: 100))
                .foregroundColor(textColor)
                .kerning(25)
                .padding(.horizontal, 50)
                .animation(.easeInOut(duration: 2), value: scale)
                .scaleEffect(scale ? 1.2 : 1)
                .onAppear{
                    if show {
                        textColor = syllable.getCardColor()
                    }
                }
                .onChange(of: show) { newValue in
                    textColor = syllable.getCardColor()
                }
        }.background(
            Image(left ? "left" : "right")
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height)
                .shadow(color: Color.Blue1.opacity(0.15),radius: 20, y: 8)
        )
    }
}

struct SyllableLabel_Previews: PreviewProvider {
    static var previews: some View {
        SyllableLabel(left: false, scale: .constant(false), syllable: "bu", height: 200, width: 300, show: .constant(true))
    }
}

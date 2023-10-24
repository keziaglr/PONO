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
    @State var vm = FlowScreenViewModel()
    @State private var dragOffset = 0.0
    
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
        }.offset(x: dragOffset)
        .animation(.easeOut(duration: 1), value: dragOffset)
        .onChange(of: show) { newValue in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                if position == "left"{
                    dragOffset = dragOffset - 100.0
                }else{
                    dragOffset = dragOffset + 100.0
                }
            }
        }
    }
}

struct SyllableLabel_Previews: PreviewProvider {
    static var previews: some View {
        SyllableLabel(position: "left", syllable: "bu", height: 200, show: .constant(true))
    }
}

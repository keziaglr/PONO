//
//  PlayRecord.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 29/10/23.
//

import SwiftUI

struct PlayRecord: View {
    
    // Play Record
    @State var action : () -> Void
    @Binding var drawingHeight: Bool
    @State var isPressed = false
    
    // Animation
    var animation: Animation {
        return .linear(duration: 0.5).repeatForever()
    }
    
    var body: some View {
//        HStack {
//            bar(low: 0.2, high: 0.2)
//                .animation(animation.speed(1.5), value: drawingHeight)
//            bar(low: 0.3, high: 0.6)
//                .animation(animation.speed(1.2), value: drawingHeight)
//            bar(low: 0.5, high: 1)
//                .animation(animation.speed(1.0), value: drawingHeight)
//            bar(low: 0.3, high: 0.5)
//                .animation(animation.speed(1.7), value: drawingHeight)
//            bar(low: 0.5, high: 0.8)
//                .animation(animation.speed(1.2), value: drawingHeight)
//            bar(low: 0.2, high: 0.3)
//                .animation(animation.speed(1.4), value: drawingHeight)
//        }.frame(width: 80)
//            .padding(.horizontal, 20)
//            .frame(width: 100, height: 96)
//            .background(Color.Red2, in: RoundedRectangle(cornerRadius: 25))
        VStack{
            
            Button(action: {
                action()
            }, label: {
                Image(systemName: "play.fill")
                    .foregroundColor(Color.Blue1)
                    .font(Font.system(size: 50, weight: .bold))
            })
                .buttonStyle(PonoButtonStyle(variant: .secondary))
        }
//        .padding(.horizontal, 20)
//        .frame(width: 200, height: 200)
//        .background(
//            RoundedRectangle(cornerRadius: 16)
//                .fill(Color.white)
//                .shadow(color: isPressed ? .clear : Color.Grey2, radius: 0, x: 0, y: 8)
//        )
//        .offset(y: isPressed ? 0 : 8)
    }
    // Animated Play Record
    func bar(low: CGFloat = 0.0, high: CGFloat = 1.0) -> some View {
        RoundedRectangle(cornerRadius: 3)
            .fill(Color.White1)
            .frame(height: (drawingHeight ? high : low) * 64)
            .frame(height: 64, alignment: .center)
    }
    
}

struct PlayRecord_Previews: PreviewProvider {
    static var previews: some View {
        PlayRecord(action: {}, drawingHeight: .constant(false))
    }
}

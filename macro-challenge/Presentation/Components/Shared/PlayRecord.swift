//
//  PlayRecord.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 29/10/23.
//

import SwiftUI

struct PlayRecord: View {
    
    // Play Record
    @State private var drawingHeight = true
    
    // Animation
    var animation: Animation {
        return .linear(duration: 0.5).repeatForever()
    }
    
    var body: some View {
        HStack {
            bar(low: 0.2, high: 0.2)
                .animation(animation.speed(1.5), value: drawingHeight)
            bar(low: 0.3, high: 0.6)
                .animation(animation.speed(1.2), value: drawingHeight)
            bar(low: 0.5, high: 1)
                .animation(animation.speed(1.0), value: drawingHeight)
            bar(low: 0.3, high: 0.5)
                .animation(animation.speed(1.7), value: drawingHeight)
            bar(low: 0.5, high: 0.8)
                .animation(animation.speed(1.2), value: drawingHeight)
            bar(low: 0.2, high: 0.3)
                .animation(animation.speed(1.4), value: drawingHeight)
        }.frame(width: 80)
            .onTapGesture {
                drawingHeight.toggle()
            }
            .padding(.horizontal, 20)
            .frame(width: 100, height: 96)
            .background(Color.Red2, in: RoundedRectangle(cornerRadius: 25))
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
        PlayRecord()
    }
}

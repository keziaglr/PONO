//
//  BubuAnimation.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 19/11/23.
//

import SwiftUI

struct BubuAnimation: View {
    @Binding var isFinish : Bool
    @State private var bubu : String = "bubu0"
    @State private var index = 0
    var body: some View {
        Image("bubu\(index)")
            .resizable()
            .scaledToFit()
            .frame(width: 400, alignment: .center)
            .onAppear{
                _ = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { _ in
                    if index <= 58 {
                        index += 1
                    } else if index == 59 {
                        isFinish = true
                    }
                    
                }
            }
            .onChange(of: index) { newValue in
                if index == 40 {
                    ContentManager.shared.playAudio("Blink")
                }
            }
    }
}

struct BubuAnimation_Previews: PreviewProvider {
    static var previews: some View {
        BubuAnimation(isFinish: .constant(false))
    }
}

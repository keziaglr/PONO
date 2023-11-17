//
//  OnboardingScreenView.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 24/10/23.
//

import SwiftUI

struct OnboardingScreenView: View {
    @Environment(\.switchableNavigate) var switchableNavigate
    @State private var hasNavigated = false
    @State private var bubu : String = "Pono0"
    
    var body: some View {
        ZStack {
            VStack{
                Image(bubu)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, alignment: .center)
                    .onAppear{
//                        var index = 0
//
//                        _ = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { (Timer) in
//
//                            self.bubu = "bubu\(index)"
//
//                            if index <= 58 {
//                                index += 1
//                                if index == 40 {
//                                    ContentManager.shared.playAudio("Blink")
//                                }
//                            }else if !hasNavigated && index == 59 {
//                                self.hasNavigated = true
//                                switchableNavigate(.home)
//                            }
//
//                        }
                    }
                Image("Pono Text")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, alignment: .center)
                    .onTapGesture {
                        switchableNavigate(.home)
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.Blue3.ignoresSafeArea())
    }
}



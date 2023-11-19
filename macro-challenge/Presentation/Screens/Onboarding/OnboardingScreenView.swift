//
//  OnboardingScreenView.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 24/10/23.
//

import SwiftUI

struct OnboardingScreenView: View {
    @Environment(\.switchableNavigate) var switchableNavigate
    @State private var isFinish = false
    
    var body: some View {
        ZStack {
            VStack{
                BubuAnimation(isFinish: $isFinish)
                Image("Pono Text")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, alignment: .center)
            }
        }
        .onChange(of: isFinish, perform: { newValue in
            if isFinish == true {
                switchableNavigate(.home)
            }
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.Blue3.ignoresSafeArea())
    }
}



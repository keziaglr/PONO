//
//  HomeScreenView.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 24/10/23.
//

import SwiftUI

struct HomeScreenView: View {
    
    @Environment(\.switchableNavigate) var switchableNavigate
    
    @State var screenHeight = CGFloat(UIScreen.main.bounds.height)
    
    var body: some View {
        VStack {
            ZStack{
                VStack {
                    Image("Cloud")
                        .resizable()
                        .scaledToFit()
                    Spacer()
                }
                VStack(spacing:0) {
                    HStack{
                        Spacer()
                        Button {
                            switchableNavigate(.report)
                        } label: {
                            Image("Bar")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 45)
                        }
                        .buttonStyle(PonoButtonStyle(variant: .tertiary))
                        .padding()
                    }
                    Spacer()
                    Rectangle()
                        .fill(Color.Grey5)
                        .frame(height: screenHeight/40)
                    Rectangle()
                        .fill(Color.Grey4)
                        .frame(height: screenHeight/5)
                }
                VStack {
                    TabView{
                        ActivityCharacter(activity: 1)
                            .onTapGesture {
                                ContentManager.shared.playAudio("session-available", type: "wav")
                                switchableNavigate(.learningActivity)
                            }
                        ActivityCharacter(activity: 2)
                            .onTapGesture {
                                ContentManager.shared.playAudio("session-unavailable", type: "wav")
                            }
                        ActivityCharacter(activity: 3)
                            .onTapGesture {
                                ContentManager.shared.playAudio("session-unavailable", type: "wav")
                            }
                        ActivityCharacter(activity: 4)
                            .onTapGesture {
                                ContentManager.shared.playAudio("session-unavailable", type: "wav")
                            }
                        ActivityCharacter(activity: 5)
                            .onTapGesture {
                                ContentManager.shared.playAudio("session-unavailable", type: "wav")
                            }
                    }
                    .offset(y: screenHeight > 900 ? screenHeight/5.7 : screenHeight/5.2)
                    .tabViewStyle(.page)
                }
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color.Blue3, Color.Blue6]), startPoint: .top, endPoint: .bottom))
            .ignoresSafeArea()
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}

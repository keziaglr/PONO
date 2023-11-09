//
//  HomeScreenView.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 24/10/23.
//

import SwiftUI

struct HomeScreenView: View {
    @State var screenHeight = CGFloat(UIScreen.main.bounds.height)
    @State var show = false
    var body: some View {
        VStack {
            if !show{
                ZStack{
                VStack(spacing:0) {
                    Spacer()
                    Rectangle()
                        .fill(Color.Grey5)
                        .frame(height: screenHeight/40)
                    Rectangle()
                        .fill(Color.Grey4)
                        .frame(height: screenHeight/5)
                }
                VStack {
                    Image("cloud")
                        .resizable()
                    .scaledToFit()
                    Spacer()
                }
                VStack {
                    TabView{
                        ActivityCharacter(activity: 1)
                            .onTapGesture {
                                show.toggle()
                            }
                        ActivityCharacter(activity: 2)
                        ActivityCharacter(activity: 3)
                        ActivityCharacter(activity: 4)
                        ActivityCharacter(activity: 5)
                    }
                    .offset(y: screenHeight > 900 ? screenHeight/5.7 : screenHeight/5.2)
                    .tabViewStyle(.page)
                }
            }
            .ignoresSafeArea()
        .background(LinearGradient(gradient: Gradient(colors: [Color.Blue3, Color.Blue6]), startPoint: .top, endPoint: .bottom))
            } else {
                FlowScreenView(show: $show)
            }
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}

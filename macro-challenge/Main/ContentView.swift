//
//  ContentView.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 05/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var activeRoute: Route = .onboarding
    
    @Environment(\.switchableNavigate) var switchableNavigate
    
    init() {
        print("called")
    }
    
    var body: some View {
        ZStack {
            switch activeRoute {
            case .onboarding:
                OnboardingScreenView()
            case .home:
                HomeScreenView()
            case .learningActivity:
                LearningFlowScreenView()
            case .report:
                //TODO: change to report view
                LearningFlowScreenView()
            }
        }
        .environment(\.switchableNavigate) { route in
            activeRoute = route
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

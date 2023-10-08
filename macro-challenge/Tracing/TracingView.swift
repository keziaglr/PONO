//
//  TracingPage.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 08/10/23.
//

import SwiftUI

// Create a UIViewRepresentable view
struct TracingViewRepresentable: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        // Create and configure your UIView here
        let myView = TracingLetter()
        
        myView.backgroundColor = UIColor(named: "bg-color")
        // Add any subviews, set up constraints, etc.
        
        return myView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Update your UIView here if needed
    }
}

struct TracingView: View {
    @Binding var page : Int
    var body: some View {
        GeometryReader { geometry in
            VStack {
                TracingViewRepresentable() // Add your UIViewRepresentable view here
                    .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
            }
        }.ignoresSafeArea()
    }
}

struct TracingView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


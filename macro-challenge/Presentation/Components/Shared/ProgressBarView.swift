//
//  ProgressBarView.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 27/10/23.
//

import SwiftUI

struct ProgressBarView: View {
    
    @State var width: CGFloat
    
    @State var height: CGFloat

    
    @Binding var progress : CGFloat
    
    var body: some View {
        ZStack (alignment: .leading) {
            Capsule()
                .fill(Color.White1)
                .frame(width: width, height: height)
            
            if progress != 0 {
                ZStack {
                    Capsule()
                        .fill(Color.Blue2)
                    Capsule()
                        .fill(Color.White1.opacity(0.25))
                        .frame(height: height/3)
                        .padding(.horizontal)
                        .padding(.bottom, height/5)
                }
                .animation(.easeInOut, value: progress)
                .frame(width: min(width * progress, width), height: height)
            }
        }
    }
}

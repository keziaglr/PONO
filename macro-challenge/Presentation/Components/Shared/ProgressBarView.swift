//
//  ProgressBarView.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 27/10/23.
//

import SwiftUI

struct ProgressBarView: View {
    @State var width : CGFloat
    @State var height : CGFloat
    @State var percent : CGFloat
    var body: some View {
        ZStack (alignment: .leading) {
            Capsule()
                .fill(Color.Grey3)
                .frame(width: width, height: height)
            if percent != 0 {
                ZStack {
                    Capsule()
                        .fill(Color.Yellow2)
                    Capsule()
                        .fill(Color.Yellow2)
                        .frame(height: height/3)
                        .padding(.horizontal)
                        .padding(.bottom, height/5)
                }.animation(.easeInOut, value: percent)
                    .frame(width: width * percent, height: height)
            }
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(width: 600, height: 25, percent: 0.5)
            
    }
}

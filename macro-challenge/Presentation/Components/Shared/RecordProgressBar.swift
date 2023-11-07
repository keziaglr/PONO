//
//  RecordProgressBar.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 05/11/23.
//

import SwiftUI

struct RecordProgressBar: View {
    let progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 24)
                    .frame(width: geometry.size.width, height: 17)
                    .opacity(0.3)
                    .foregroundColor(.gray)
                
                RoundedRectangle(cornerRadius: 24)
                    .frame(
                        width: min(progress * geometry.size.width,
                                   geometry.size.width),
                        height: 17
                    )
                    .foregroundColor(Color.Blue1)
                    .animation(.easeInOut, value: progress)
            }
        }    }
}

//#Preview {
//    RecordProgressBar(progress: 0.5)
//}

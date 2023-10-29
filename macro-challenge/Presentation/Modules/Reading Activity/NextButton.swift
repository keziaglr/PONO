//
//  NextButton.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 29/10/23.
//

import SwiftUI

struct NextButton: View {
    var body: some View {
        Button {
            
        } label: {
            Image(systemName: "arrow.right")
                .resizable()
                .frame(width: 48, height: 48)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                        .frame(width: 100, height: 78)
                        .shadow(color: .gray, radius: 2, y: 2)
                )
        }
    }
}

#Preview {
    NextButton()
}

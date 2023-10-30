//
//  NextButton.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 29/10/23.
//

import SwiftUI

struct NextButton: View {
    var body: some View {
        Image(systemName: "arrow.right")
            .font(Font.system(size: 50, weight: .bold))
            .foregroundStyle(Color.Blue1)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(.white)
                    .frame(width: 100, height: 78)
                    .shadow(color: Color.Grey3, radius: 3, y: 2)
            )
    }
}

struct NextButton_Previews: PreviewProvider {
    static var previews: some View {
        NextButton()
    }
}

//
//  ButtonView.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 27/10/23.
//

import SwiftUI

struct ButtonView: View {
    @State var height : CGFloat
    @State var image : String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.Blue2)
                .frame(height: height)
            Image(systemName: image)
                .foregroundColor(Color.White1)
                .font(.largeTitle)
        }.padding()
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(height: 72, image: "arrow.right")
    }
}

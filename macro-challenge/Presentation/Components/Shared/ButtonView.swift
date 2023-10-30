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
                            .fill(Color.blue) // Background color
                            .frame(height: 72)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
            Image("\(image)")
            
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(height: 72, image: "ic_reload_white")
    }
}

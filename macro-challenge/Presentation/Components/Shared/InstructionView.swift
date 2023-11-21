//
//  InstructionView.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 27/10/23.
//

import SwiftUI

struct InstructionView: View {
    
    @State var height : CGFloat
    @Binding var message : String
    
    var body: some View {
        HStack {
            Image(systemName: "speaker.wave.2.fill")
                .font(.title)
                .foregroundColor(Color.Blue2)
            
            Text(message)
                .textStyle(style: .heading5)
        }
        .padding(20)
        .background(
            Capsule()
                .fill(Color.white)
                .frame(height: height)
                .shadow(color: Color.Blue2.opacity(0.15),
                        radius: 20)
        )
    }
}

struct InstructionView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionView(height: 67, message: .constant("Selamat"))
    }
}

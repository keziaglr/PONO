//
//  BackCardView.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 26/10/23.
//

import SwiftUI

struct BackCardView: View {
    @Binding var degree : Double
    
    private var ponoColor = ""
    
    init(
        degree: Binding<Double>
    ) {
        self._degree = degree
    }
    
    var body: some View {
        ZStack {
            Image("back-card")
                .resizable()
                .frame(width: 170, height: 255)
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct BackCardView_Previews: PreviewProvider {
    static var previews: some View {
        BackCardView(degree: .constant(0))
    }
}

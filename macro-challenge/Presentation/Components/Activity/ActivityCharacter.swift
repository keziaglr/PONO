//
//  Activity1.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 08/11/23.
//

import SwiftUI

struct ActivityCharacter: View {
    @State var screenHeight = CGFloat(UIScreen.main.bounds.height)
    @State var activity : Int = 1
    var body: some View {
        VStack (spacing: 50) {
            VStack(spacing: -10) {
                Image("activity-\(activity)")
                    .resizable()
                    .scaledToFit()
                .frame(height: screenHeight/3)
                VStack(spacing: -10) {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.Grey4)
                        .frame(width:screenHeight/2.5, height: screenHeight/50)
                    Rectangle()
                        .fill(Color.Grey4)
                        .frame(width:screenHeight/2.5, height: screenHeight/50)
                }
            }
            VStack {
                Text("Aktivitas \(activity)")
                    .textStyle(style: .heading4)
                    .foregroundColor(Color.White1)
                Text(getDesc(activity:activity))
                    .textStyle(style: .largeText)
                    .foregroundColor(Color.White1)
            }
        }
        
    }
    
    func getDesc(activity: Int) -> String {
        switch activity{
        case 1:
            return "b, d, m, n, p"
        case 2:
            return "c, f, g, h, j"
        case 3:
            return "k, l, r, s, t"
        default:
            return "- dalam perjalanan -"
        }
    }
}

struct ActivityCharacter_Previews: PreviewProvider {
    static var previews: some View {
        ActivityCharacter(activity: 3)
    }
}

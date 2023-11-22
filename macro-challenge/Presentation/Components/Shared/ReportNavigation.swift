//
//  ReportNavigation.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 16/11/23.
//

import SwiftUI

struct ReportNavigation: View {
    var title : String
    var iconName : String
    var total : Int
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Text(title)
                    .font(.custom("Quicksand-Bold", size: 12))
                    .textCase(.uppercase)
                    .foregroundStyle(Color.Black1)
                    .padding()
                    .frame(width: 140)
                HStack {
                    Image("\(iconName)")
                        .font(.system(size: 40))
                        .symbolRenderingMode(.multicolor)
                    Text("\(total)")
                        .font(.system(size: 40, weight: .medium, design: .rounded))
                        .foregroundStyle(Color.Black1)
                }
            }
            .frame(width: 180.67, height: 150)
            .background(
                RoundedRectangle(cornerRadius: 24.0)
                    .fill(isSelected ? .white : .white.opacity(0.5))
            )
            .padding()
        }
    }
    
    
}

#Preview {
    ReportNavigation(title: "Suku Kata Dipelajari", iconName: "hourglass", total: 20, isSelected: true, action: {})
}

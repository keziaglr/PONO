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
                    .foregroundColor(Color(red: 0.52, green: 0.52, blue: 0.52))
                    .padding()
                HStack {
                    Image("\(iconName)")
                        .font(.system(size: 40))
                        .symbolRenderingMode(.multicolor)
                    Text("\(total)")
                        .font(.custom("Quicksand-Medium", size: 40))
                        .foregroundStyle(.black)
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
    ReportNavigation(title: "Total Sesi", iconName: "hourglass", total: 20, isSelected: true, action: {})
}

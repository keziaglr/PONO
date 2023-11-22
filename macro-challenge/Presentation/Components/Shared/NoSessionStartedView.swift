//
//  ReportNoSessionView.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 19/11/23.
//

import SwiftUI

struct NoSessionStartedView: View {
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    Image("activity-1")
                        .resizable()
                        .frame(width: 134, height: 161)
                }
                .frame(width: 268, height: 153)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.White1)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.Grey3, lineWidth: 2)
                )
                // title
                VStack {
                    Text("Mulai Sesi, Yuk!")
                        .font(.custom("Quicksand-bold", size: 32))
                        .padding()
                    
                    Text("Sepertinya kamu belum melakukan sesi bersama PONO")
                        .font(.custom("Quicksand-Medium", size: 16))
                        .foregroundStyle(Color.Grey5)
                        .frame(width: 332)
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                // Start session button
                Button {
                    // action mulai sesi
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 256, height: 57)
                            .background(Color(red: 1, green: 0.79, blue: 0.23))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.9, green: 0.68, blue: 0.09), lineWidth: 1)
                            )
                        // text
                        Text("Mulai Latihan")
                            .font(.custom("Quicksand-Bold", size: 28))
                            .foregroundStyle(Color.White2)
                    }
                }
//                .offset(y: 40)
            }
        }
        .frame(width: 590, height: 549)
        .background(
            RoundedRectangle(cornerRadius: 30.0)
                .fill(.white)
        )    }
}

#Preview {
    NoSessionStartedView()
}

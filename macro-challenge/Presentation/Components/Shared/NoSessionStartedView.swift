//
//  ReportNoSessionView.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 19/11/23.
//

import SwiftUI

struct NoSessionStartedView: View {
    let startExercise: () -> Void
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    Image("activity-1")
                        .resizable()
                        .frame(width: 134, height: 161)
                }
                .frame(width: 268, height: 180)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.White1)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.Grey3, lineWidth: 2)
                )
                VStack {
                    Text("Mulai Sesi, Yuk!")
                        .font(.custom("Quicksand-bold", size: 32))
                        .padding()
                    
                    Text("Sepertinya kamu belum melakukan latihan bersama PONO")
                        .textStyle(style: .heading6)
                        .foregroundStyle(Color.Grey5)
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                Button {
                    startExercise()
                } label: {
                    ZStack {
                        Text("Mulai Latihan")
                            .font(.custom("Quicksand-Bold", size: 28))
                            .foregroundStyle(Color.White2)
                    }
                }
                .buttonStyle(PonoButtonStyle(variant: .primary))
                .padding()
            }
        }
        .frame(width: 590, height: 549)
        .background(
            RoundedRectangle(cornerRadius: 30.0)
                .fill(.white)
        )    }
}

//#Preview {
//    NoSessionStartedView()
//}

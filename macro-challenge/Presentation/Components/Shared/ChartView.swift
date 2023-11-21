//
//  ChartView.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 17/11/23.
//

import SwiftUI
import Charts

struct SessionData: Identifiable {
    var type: String
    var count: Double
    var id = UUID()
}

struct ChartView: View {
    var data: [SessionData] = [
        .init(type: "Sen", count: 5),
        .init(type: "Sel", count: 4),
        .init(type: "Rab", count: 4),
        .init(type: "Kam", count: 5),
        .init(type: "Jum", count: 4),
        .init(type: "Sab", count: 5),
        .init(type: "Min", count: 4)
    ]
    var body: some View {
        VStack(alignment: .leading) {
            Text("TOTAL SESI")
                .textCase(.uppercase)
                .font(.custom("Quicksand-Bold", size: 14))
                .padding(.top, 15)
                .padding(.horizontal)
            Text("Rata-rata: 11 sesi")
                .font(.custom("Quicksand", size: 12))
                .padding(.horizontal)
            Chart {
                ForEach(data) { session in
                    BarMark(
                        x: .value("Day", session.type),
                        y: .value("Total", session.count)
                    )
                    .cornerRadius(4.0)
                    .foregroundStyle(Color.Yellow2)
                }
            }
            .padding()
            .frame(width: 560, height: 305)
        }
        .padding()
        .background(.white)
        .cornerRadius(30)
    }
}

#Preview {
    ChartView()
}

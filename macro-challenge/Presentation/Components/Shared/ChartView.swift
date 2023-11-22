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
    @ObservedObject private var viewModel : ReportViewModel
    
    init() {
        viewModel = ReportViewModel()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("TOTAL LATIHAN")
                .textCase(.uppercase)
                .font(.custom("Quicksand-Bold", size: 14))
                .padding(.top, 15)
                .padding(.horizontal)
            Text("Rata-rata: \(viewModel.average) latihan")
                .font(.custom("Quicksand", size: 12))
                .padding(.horizontal)
            Spacer()
            Chart {
                ForEach(viewModel.data) { session in
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
            Spacer()
        }
        .padding()
        .frame(maxWidth: 590, maxHeight: .infinity)
        .background(.white)
        .cornerRadius(30)
        .onAppear {
            Task {
                await viewModel.getPracticeData()
            }
        }
    }
}

//#Preview {
//    ChartView()
//}

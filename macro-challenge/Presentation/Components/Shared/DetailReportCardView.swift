//
//  DetailReportCardView.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 21/11/23.
//

import SwiftUI

struct DetailReportCardView: View {
    @ObservedObject var viewModel : ReportViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // MARK: Syllable card
            if !viewModel.isWord {
                HStack {
                    VStack {
                        Image("word-percentage")
                            .padding(.horizontal, 11)
                        Spacer()
                    }
                    VStack(alignment: .leading) {
                        Text("Identifikasi Suku Kata")
                            .font(.custom("Quicksand-Bold", size: 13))
                        
                        VStack(alignment: .leading) {
                            Text(viewModel.getDescriptionSucceedAttempts()) // total berhasil
                                .font(.custom("Quicksand-Bold", size: 12))
                            Text(viewModel.getDescription())
                                .font(.custom("Quicksand-Medium", size: 11))
                        }
                        .foregroundStyle(viewModel.getTextColorWords())
                        .offset(y: 12)
                        
                        Spacer()
                    }
                }
                .padding(.top, 20)
                .padding(10)
                
                // Line
                HStack(alignment: .center) {
                    Spacer()
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 205, height: 1)
                        .background(Color(red: 0.89, green: 0.89, blue: 0.89))
                    Spacer()
                }
                .padding(10)
                
            }
            // MARK: Syllable Speech
            HStack {
                VStack {
                    Image("speech-percentage")
                        .padding(.horizontal, 11)
                    Spacer()
                }
                
                VStack(alignment: .leading) {
                    Text("Pelafalan")
                        .font(.custom("Quicksand-Bold", size: 13))
                    VStack(alignment: .leading) {
                        Text(viewModel.getDescriptionSucceedAttempts()) // total berhasil
                            .font(.custom("Quicksand-Bold", size: 12))
                        Text(viewModel.getDescription())
                            .font(.custom("Quicksand-Medium", size: 11))
                    }
                    .foregroundStyle(viewModel.getTextColorWords())
                    .offset(y: 12)
                    
                    Spacer()
                }
                
            }
            .padding(.top, viewModel.isWord ? 20 : 0)
            .padding(10)
            
            // MARK: Total Latihan
            HStack {
                Spacer()
                Text("dari ")
                    .font(.custom("Quicksand-medium", size: 11))
                +
                Text("\(viewModel.getTotalAttempts()) latihan") // jumlah latihan
                    .font(.custom("Quicksand-Bold", size: 11))
            }
            .padding(10)
            
        }
        .frame(width: 250, height: 230)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .fill(Color.Grey3)
        )
        .zIndex(1.0)
    }
    
}

//#Preview {
//    DetailReportCardView(viewModel: ReportViewModel)
//}

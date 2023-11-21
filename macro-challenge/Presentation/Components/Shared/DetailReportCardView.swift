//
//  DetailReportCardView.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 21/11/23.
//

import SwiftUI

struct DetailReportCardView: View {
    @State var condition : String
    @State var wordSpeechSucceed : Int
    @State var syllableSpeechSucceed : Int
    @State var syllableCardSucceed : Int
    @State var totalExercise : Int
    
    @State var isWord : Bool
    
//
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // MARK: Syllable
            if !isWord {
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
                                Text("Belum mencapai 10x") // total berhasil
                                    .font(.custom("Quicksand-Bold", size: 12))
    //                                .foregroundStyle(Color.Grey4)

                                Text(getDescription())
                                    .font(.custom("Quicksand-Medium", size: 11))
    //                                .foregroundStyle(Color.Grey4)
                            }
                            .foregroundStyle(getTextColor())
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
                
                // MARK: Word
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
                                Text("10x berhasil") // total berhasil
                                    .font(.custom("Quicksand-Bold", size: 12))
    //                                .foregroundStyle(Color.Grey4)
                                Text(getDescription())
                                    .font(.custom("Quicksand-Medium", size: 11))
    //                                .foregroundStyle(Color.Grey4)
                            }
                            .foregroundStyle(getTextColor())
                            .offset(y: 12)
                            
                            Spacer()
                    }
                    
                }
                .padding(10)
                
            } // close if
            else {
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
                                Text("10x berhasil") // total berhasil
                                    .font(.custom("Quicksand-Bold", size: 12))
    //                                .foregroundStyle(Color.Grey4)
                                Text(getDescription())
                                    .font(.custom("Quicksand-Medium", size: 11))
    //                                .foregroundStyle(Color.Grey4)
                            }
                            .foregroundStyle(getTextColor())
                            .offset(y: 12)
                            
                            Spacer()
                    }
                    
                }
                .padding(.top, 20)
                .padding(10)
            }
            
            // MARK: Total Latihan
            HStack {
                Spacer()
                Text("dari ")
                    .font(.custom("Quicksand-medium", size: 11))
                +
                Text("25 latihan") // jumlah latihan
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
    
    func getTextColor() -> Color {
        switch condition {
        case "underAverage":
            return Color.Red2
        case "aboveAverage":
            return Color.Green2
        default:
            return Color.Grey4
        }
    }
    
    func getTextColor1(forValue value: Int) -> Color {
        switch value {
        case let x where x < 60:
            return Color.Red2
        case let x where x > 60:
            return Color.Green2
        default:
            return Color.Grey4
        }
    }
    
    func getDescription() -> String {
        switch condition {
        case "underAverage":
            return "Masih perlu latihan lagi!"
        case "aboveAverage":
            return "Kemajuan yang luar biasa!"
        default:
            return "Analitik kata belum dapat dibuka"
        }
    }
}

#Preview {
    DetailReportCardView(condition: "underAverage", wordSpeechSucceed: 10, syllableSpeechSucceed: 15, syllableCardSucceed: 12, totalExercise: 25, isWord: true)
}

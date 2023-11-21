//
//  EndStage.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 21/11/23.
//

import SwiftUI

struct Congratulation: View {
    @State var word : Word = Word(content: "mami", level: 3, syllables: [Syllable(id: UUID(), content: "ma"), Syllable(id: UUID(), content: "mi")])
    var body: some View {
        VStack(spacing: .spacing40) {
            Text("Selamat!")
                .textStyle(style: .heading4)
            Image("Congratz")
                .resizable()
                .scaledToFit()
                .frame(width: 250)
            HStack {
                HStack {
                    Image("Open book")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 25)
                    Text("\(word.content)")
                        .textStyle(style: .heading6)
                }
                Spacer()
                    .frame(width: .spacing56)
                HStack {
                    Image("Puzzle piece")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 25)
                    Text("\(word.syllables[0].content), \(word.syllables[1].content)")
                        .textStyle(style: .heading6)
                }
            }
            .cornerRadius(15)
            .padding(.spacing24)
            .background(Color.White1)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.Grey3, lineWidth: 2)
            )
        }
        .padding(.spacing32)
        .frame(width: 800, height: 350)
        .cornerRadius(40)
        .background(Color.white)
    }
}

struct EndStage_Previews: PreviewProvider {
    static var previews: some View {
        Congratulation()
    }
}

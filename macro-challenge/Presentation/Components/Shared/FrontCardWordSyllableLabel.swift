//
//  LearnedWordLabel.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 16/11/23.
//

import SwiftUI

struct FrontCardWordSyllableLabel: View {
    @State var text : String
    @State var learnedType : String
    //    @Binding var selectedWord: String?
    @State var condition: String
    var isWord : Bool
    var rating : Int
    
    @State private var isExpanded = false
    var body: some View {
        HStack {
            Text(text)
                .font(.custom("Quicksand-Bold", size: 20))
                .foregroundStyle(condition == "default" ? Color.black : Color.white)
                .padding(.horizontal)
            Spacer()
            RatingView(rating: rating)
        }
        .padding(.horizontal, 1)
        .padding(.vertical, 14)
        .frame(width: 250, height: isExpanded ? 40 : 70, alignment: .center)
        //        .background(getBackgroundColor())
        .background(
            UnevenRoundedRectangle(topLeadingRadius: 10, bottomLeadingRadius: isExpanded ? 0 : 10, bottomTrailingRadius: isExpanded ? 0 : 10, topTrailingRadius: 10)
                .fill(getBackgroundColor())
            
        )
        .onTapGesture {
            withAnimation {
                isExpanded.toggle()
            }
        }
        .zIndex(2.0)
        
        if isExpanded {
            DetailReportCardView(condition: "underAverage", wordSpeechSucceed: 10, syllableSpeechSucceed: 15, syllableCardSucceed: 4, totalExercise: 25, isWord: isWord)
                .offset(y: -20)
        }
    }
    

    
    func getBackgroundColor() -> Color {
        switch condition {
        case "underAverage":
            return Color.Red2
        case "aboveAverage":
            return Color.Green2
        default:
            return Color.White1
        }
    }
    
    
}

#Preview {
    FrontCardWordSyllableLabel(text: "papi", learnedType: "syllable", condition: "default", isWord: true, rating: 1)
}

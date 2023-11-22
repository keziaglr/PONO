//
//  LearnedWordLabel.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 16/11/23.
//

import SwiftUI

enum CardReportType {
    case empty
    case fail
    case success
}

struct FrontCardWordSyllableLabel: View {
    @ObservedObject var viewModel: ReportViewModel
    @State private var isExpanded = false
    
    var body: some View {
        HStack {
            Text(viewModel.getText())
                .font(.custom("Quicksand-Bold", size: 20))
                .foregroundStyle(viewModel.getCondition() == .empty ? Color.black : Color.white)
                .padding(.horizontal)
            Spacer()
            if !viewModel.isWord{
                RatingView(rating: viewModel.newCalculateRating())
            }
        }
        .padding(.horizontal, 1)
        .padding(.vertical, 14)
        .frame(width: 250, height: isExpanded ? 40 : 70, alignment: .center)
        .background(
            UnevenRoundedRectangle(topLeadingRadius: 10, bottomLeadingRadius: isExpanded ? 0 : 10, bottomTrailingRadius: isExpanded ? 0 : 10, topTrailingRadius: 10)
                .fill(viewModel.getBackgroundColor())
            
        )
        .onTapGesture {
            withAnimation {
                isExpanded.toggle()
            }
        }
        .zIndex(2.0)
        
        if isExpanded {
            DetailReportCardView(viewModel: viewModel)
                .offset(y: -20)
        }
    }
}
//
//#Preview {
//    FrontCardWordSyllableLabel(word: PracticedWord())
//}

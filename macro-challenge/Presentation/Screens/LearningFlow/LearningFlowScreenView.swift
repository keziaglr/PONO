//
//  LearningFlowScreenView.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 15/11/23.
//

import SwiftUI

struct LearningFlowScreenView: View {
    
    @Environment(\.switchableNavigate) var switchableNavigate
    
    @ObservedObject var viewModel: LearningFlowScreenViewModel
    
    init() {
        self.viewModel = LearningFlowScreenViewModel()
    }
    
    var body: some View {
        ZStack {
            Image("Cloud")
                .resizable()
                .scaledToFit()
            
            VStack {
                LearningProgressView(onClose: { switchableNavigate(.home) })
                if let activeLearningActivity = viewModel.activeLearningActivity {
                    switch activeLearningActivity {
                        
                    case .breakWord(let word):
                        BreakWordActivityView(learningWord: word, 
                                              onNext: viewModel.navigateToNextActivity)
                        
                    case .card(let word, let syllableOrder):
                        CardActivityView(learningWord: word,
                                         syllableOrder: syllableOrder,
                                         onNext: viewModel.navigateToNextActivity)
                        
                    case .pronunciation(let word, let syllableOrder):
                        PronunciationActivityView(learningWord: word,
                                                  syllableOrder: syllableOrder, onNext: viewModel.navigateToNextActivity)
                        
                    case .combineSyllable(let word):
                        CombineSyllableActivityView(learningWord: word, 
                                                    onNext: viewModel.navigateToNextActivity)
                        
                    case .endStage(let word):
                        EndStageActivityView(learningWord: word, onNext: viewModel.navigateToNextActivity, backHome: {switchableNavigate(.home)} )
                    }
                }
                
            }
        }
        .background(Color.Blue3)
    }
    
    func LearningProgressView(onClose: @escaping () -> Void) -> some View {
        
        let screenWidth = CGFloat(UIScreen.main.bounds.width)
        let screenHeight = CGFloat(UIScreen.main.bounds.height)
        
        return VStack{
            HStack {
                Image(systemName: "xmark")
                    .font(Font.system(size: 34, weight: .bold))
                    .foregroundColor(Color.Red2)
                    .scaledToFit()
                    .padding(.trailing)
                    .onTapGesture {
                        onClose()
                    }
                
                ProgressBarView(width: screenWidth / 1.1, height: screenHeight / 25, progress: $viewModel.progress)
                    
            }
            .padding()
        }
    }
}

//#Preview {
//    LearningFlowScreenView()
//}

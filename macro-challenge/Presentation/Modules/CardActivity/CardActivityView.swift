//
//  CardActivityView.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 15/11/23.
//

import SwiftUI
import AVKit

struct CardActivityView: View {
    
    @ObservedObject private var viewModel: RefactoringCardActivityViewModel
    
    private let onNext: () -> Void
    
    // UI-related properties
    @State var width : CGFloat = 500
    @State var height : CGFloat = 200
    @State var screenWidth = CGFloat(UIScreen.main.bounds.width)
    @State var screenHeight = CGFloat(UIScreen.main.bounds.height)
    @State private var scale : [Bool] = [false, false]
    
    init(learningWord: Word, syllableOrder: SyllableOrder, onNext: @escaping () -> Void) {
        self.viewModel = RefactoringCardActivityViewModel(learningWord: learningWord, syllableOrder: syllableOrder)
        self.onNext = onNext
    }
    
    var body: some View {
        ZStack {
            VStack {
                InstructionView(height: screenHeight / 12,
                                message: viewModel.currentInstruction?.text ?? "")
                .padding()
                .opacity(viewModel.currentInstruction == nil ? 0 : 1)
                .onTapGesture {
                    viewModel.playInstruction()
                }
                
                Spacer()
            }
            
            ZStack (alignment: .topLeading) {
                QRCameraView(cameraSession: viewModel.qrScannerManager.captureSession, frameSize: CGSize(width: 900, height:450))
                    .frame(width: 900, height: 450)
                MergedSyllable(word: viewModel.learningWord, syllableType: viewModel.syllableOrder)
                    .padding(.top, 20)
                    .onTapGesture {
                        onNext()
                    }
            }
        }
        
    }

}

#Preview {
    CardActivityView(learningWord: PreviewDataResources.word, syllableOrder: .firstSyllable, onNext: { })
}

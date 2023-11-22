//
//  CardActivityView.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 15/11/23.
//

import SwiftUI
import AVKit

struct CardActivityView: View {
    
    @ObservedObject private var viewModel: CardActivityViewModel
    
    private let onActivityDone: (Syllable, Bool) -> Void
    private let onNext: () -> Void
    
    // UI-related properties
    @State var width : CGFloat = 500
    @State var height : CGFloat = 200
    @State var screenWidth = CGFloat(UIScreen.main.bounds.width)
    @State var screenHeight = CGFloat(UIScreen.main.bounds.height)
    @State private var scale : [Bool] = [false, false]
    @State private var instructionText = ""
    @State private var isCorrect: Bool?
    
    init(learningWord: Word, syllableOrder: SyllableOrder, onActivityDone: @escaping (Syllable, Bool) -> Void, onNext: @escaping () -> Void) {
        self.viewModel = CardActivityViewModel(learningWord: learningWord, syllableOrder: syllableOrder)
        self.onActivityDone = onActivityDone
        self.onNext = onNext
    }
    
    var body: some View {
        ZStack {
            VStack {
                InstructionView(height: screenHeight / 12,
                                message: $instructionText)
                .onAppear {
                    instructionText = viewModel.currentInstruction?.text ?? ""
                }
                .onChange(of: viewModel.currentInstruction, perform: { _ in
                    instructionText = viewModel.currentInstruction?.text ?? ""
                })
                .padding()
                .opacity(viewModel.currentInstruction == nil ? 0 : 1)
                .onTapGesture {
                    viewModel.playInstruction(isReplay: true)
                }
                
                Spacer()
            }
            
            ZStack (alignment: .topLeading) {
                if isCorrect == nil {
                    ZStack (alignment: .topLeading) {
                        QRCameraView(cameraSession: viewModel.qrScannerManager.captureSession, frameSize: CGSize(width: 900, height:450))
                            .frame(width: 900, height: 450)
                            .cornerRadius(20)
                        MergedSyllableView(word: viewModel.learningWord, syllableType: viewModel.syllableOrder)
                            .padding(.top, 20)
                            .onTapGesture {
                                viewModel.getQrScannedDataDelegate()
                            }
                    }
                } else {
                    PreviewCardView(viewModel: viewModel, onNext: {
                        onNext()
                    }, onRetry: {
                        isCorrect = nil
                        viewModel.startScanning()
                    }, syllable: viewModel.syllableOrder == .firstSyllable ? viewModel.learningWord.syllables.last ?? Syllable(id: UUID(), content: "ma") : viewModel.learningWord.syllables.last ?? Syllable(id: UUID(), content: "ma"))
                }
            }.onReceive(viewModel.$isCorrect, perform: { isCorrect in
                self.isCorrect = isCorrect
            })
            
        }.onAppear {
            viewModel.playInstruction()
        }.onChange(of: isCorrect) { newValue in
            viewModel.playInstruction()
        }
        .onChange(of: viewModel.isCorrect) { newValue in
            if let newValue {
                guard let syllable = viewModel.syllable else { return }
                onActivityDone(syllable, newValue)
            }
        }
        
    }
}

//#Preview {
//    CardActivityView(learningWord: PreviewDataResources.word, syllableOrder: .firstSyllable, onNext: { })
//}


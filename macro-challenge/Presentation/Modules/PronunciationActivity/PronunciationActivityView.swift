//
//  PronunciationActivityView.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 15/11/23.
//

import SwiftUI

struct PronunciationActivityView: View {
    
    @ObservedObject private var viewModel: PronunciationActivityViewModel
    
    private let onNext: () -> Void
    
    private let screenHeight = CGFloat(UIScreen.main.bounds.height)
    
    init(learningWord: Word, syllableOrder: SyllableOrder?, onNext: @escaping () -> Void) {
        self.viewModel = PronunciationActivityViewModel(learningWord: learningWord, syllableOrder: syllableOrder)
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

            
            if viewModel.pronunciationStatus == .correct ||
                viewModel.pronunciationStatus == .wrong {
                
                PlayPronunciationRecordView(labelText: viewModel.syllable?.content ?? viewModel.learningWord.content,
                                            isDisabled: viewModel.isAudioRecordingAndRecognizing,
                                            onPlaySampleSound: viewModel.playWordOrSyllableSound,
                                            onPlayRecord: viewModel.playVoiceRecord,
                                            onNext: onNext,
                                            onRetry: viewModel.retryVoiceRecognitionAndRecording)
            }else{
                VStack {
                    Spacer()
                    PronounceInstruction(viewModel.syllable?.content ?? viewModel.learningWord.content,
                                         isDisabled: viewModel.isAudioRecordingAndRecognizing,
                                         onClick: viewModel.playWordOrSyllableSound)
                    
                    Spacer()
                    RecordingAudio(pronunciationStatus: $viewModel.pronunciationStatus)
                }
            }
        }
        .padding()
        .onAppear{
            viewModel.startVoiceRecognitionAndRecording()
            viewModel.playInstruction()
        }
    }
}

#Preview {
    PronunciationActivityView(learningWord: PreviewDataResources.word, 
                              syllableOrder: .firstSyllable,
                              onNext: { })
}


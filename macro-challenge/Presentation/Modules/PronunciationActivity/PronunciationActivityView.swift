//
//  PronunciationActivityView.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 15/11/23.
//

import SwiftUI

struct PronunciationActivityView: View {
    
    @ObservedObject private var viewModel: PronunciationActivityViewModel
    
    private let onActivityDone: (Syllable?, Bool) -> Void
    private let onNext: () -> Void
    
    private let screenHeight = CGFloat(UIScreen.main.bounds.height)
    
    init(learningWord: Word, syllableOrder: SyllableOrder?, onActivityDone: @escaping (Syllable?, Bool) -> Void, onNext: @escaping () -> Void) {
        self.viewModel = PronunciationActivityViewModel(learningWord: learningWord, syllableOrder: syllableOrder)
        self.onActivityDone = onActivityDone
        self.onNext = onNext
    }
    
    var body: some View {
        ZStack {
            if viewModel.isShowPlayRecording {
                PlayPronunciationRecordView(labelText: viewModel.syllable?.content ?? viewModel.learningWord.content,
                                            isDisabled: viewModel.isAudioRecordingAndRecognizing,
                                            onPlaySampleSound: viewModel.playWordOrSyllableSound,
                                            onPlayRecord: viewModel.playVoiceRecord,
                                            onNext: onNext,
                                            onRetry: viewModel.retryVoiceRecognitionAndRecording)
            } else {
                VStack {
                    Spacer()
                    PronounceInstruction(viewModel.syllable?.content ?? viewModel.learningWord.content,
                                         isDisabled: viewModel.isAudioRecordingAndRecognizing,
                                         onClick: viewModel.playWordOrSyllableSound)
                    
                    Spacer()
                    RecordingAudioView(pronunciationStatus: $viewModel.pronunciationStatus)
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.startVoiceRecognitionAndRecording()
            viewModel.playInstruction()
        }
        .onChange(of: viewModel.isShowPlayRecording) { _ in
            viewModel.playInstruction()
        }
        .onChange(of: viewModel.pronunciationStatus) { newValue in
            if newValue == .correct {
                onActivityDone(viewModel.syllable, true)
            } else if newValue == .wrong {
                onActivityDone(viewModel.syllable, false)
            }
        }
    }
}

struct OnboardingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PronunciationActivityView(learningWord: PreviewDataResources.word,
                                  syllableOrder: .firstSyllable, onActivityDone: { syllable, isCorrect in },
                                  onNext: { })
    }
}


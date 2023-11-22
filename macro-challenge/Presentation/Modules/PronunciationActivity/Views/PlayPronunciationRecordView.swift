//
//  PlayPronunciationRecordView.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 15/11/23.
//

import SwiftUI

struct PlayPronunciationRecordView: View {
    
    let labelText: String
    let isDisabled: Bool
    let onPlaySampleSound: () -> Void
    let onPlayRecord: () -> Void
    let onNext: () -> Void
    let onRetry: () -> Void
    @Binding var duration: TimeInterval?
    
    @State private var drawingHeight = true
    @State private var isRecording = false
    @State private var isDone = false
    @State private var buttonTapped = false
    
    var body: some View {
        ZStack {
            VStack {
                
                Spacer()
                
                if isDone {
                    HStack {
                        Button {
                            buttonTapped.toggle()
                            onNext()
                        } label: {
                            Image(systemName: "arrow.right")
                        }
                        .buttonStyle(PonoButtonStyle(variant: .primary))
                        .disabled(buttonTapped)
                        
                        Button {
                            onRetry()
                        } label: {
                            Image(systemName: "arrow.counterclockwise")
                        }
                        .buttonStyle(PonoButtonStyle(variant: .tertiary))
                        
                    }
                    .padding(20)
                }
            }
            
            HStack{
                PronounceInstruction(labelText, isDisabled: isDisabled, onClick: onPlaySampleSound)
                
                PlayRecord(action: {
                    onPlayRecord()
                    drawingHeight.toggle()
                },
                           drawingHeight: $drawingHeight,
                           isDone: $isDone,
                           duration: $duration)
                
            }
        }
    }
}

struct PlayPronunciationRecordView_Previews: PreviewProvider {
    static var previews: some View {
        PlayPronunciationRecordView(labelText: "ma",
                                    isDisabled: false,
                                    onPlaySampleSound: { },
                                    onPlayRecord: { },
                                    onNext: { },
                                    onRetry: { },
                                    duration: .constant(0.0))
    }
}

//
//  BreakWordActivityViewModel.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 15/11/23.
//

import SwiftUI

class BreakWordActivityViewModel: ObservableObject {
    
    let learningWord: Word
    
    private var instructions: [Instruction] {
        [
            VoiceResources.breakWordActivityOpeningInstruction(learningWord),
            VoiceResources.breakWordActivityClosingInstruction(learningWord)
        ]
    }
    
    @Published var currentInstruction: Instruction?
    @Published var currentInstructionVoiceIndex: Int = 0
    
    let audioManager = AudioManager()
    
    init(learningWord: Word) {
        self.learningWord = learningWord
    }
    
    func playInstruction() {
        guard !instructions.isEmpty else {
            return
        }
        guard let currentInstruction else {
            currentInstruction = instructions.first
            return
        }
        guard let currentIndex = instructions.firstIndex(where: { $0 == currentInstruction }) else {
            return
        }
        let nextInstructionIndex = currentIndex + 1
        guard let nextInstruction = instructions[safe: nextInstructionIndex] else {
            return
        }
        let instructionVoices = nextInstruction.voices
        audioManager.playQueue(instructionVoices, changeHandler: instructionVoiceChangeHandler)
    }
    
    private func instructionVoiceChangeHandler(_ newIndex: Int) {
        currentInstructionVoiceIndex = newIndex
    }
}
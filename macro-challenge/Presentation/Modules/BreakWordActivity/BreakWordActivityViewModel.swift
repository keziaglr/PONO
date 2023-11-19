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
    
    func playInstruction(isReplay: Bool = false) {
        guard !instructions.isEmpty else {
            return
        }
        guard let currentInstruction else {
            if let currentInstruction = instructions.first{
                playInstruction(currentInstruction)
                return
            }
            return
        }
        guard !isReplay else {
            playInstruction(currentInstruction)
            return
        }
        guard let currentIndex = instructions.firstIndex(where: { $0 == self.currentInstruction }) else {
            return
        }
        let nextInstructionIndex = currentIndex + 1
        guard let nextInstruction = instructions[safe: nextInstructionIndex] else {
            self.currentInstruction = nil
            playInstruction()
            
            return
        }
        self.currentInstruction = nextInstruction
        playInstruction(nextInstruction)
    }
    
    private func playInstruction(_ instruction: Instruction) {
        let instructionVoices = instruction.voices
        audioManager.playQueue(instructionVoices, changeHandler: instructionVoiceChangeHandler)
    }
    
    private func instructionVoiceChangeHandler(_ queueCount: Int, _ newIndex: Int) {
        currentInstructionVoiceIndex = newIndex
    }
}

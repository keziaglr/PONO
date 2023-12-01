//
//  EndStageActivityViewModel.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 21/11/23.
//

import SwiftUI

class EndStageActivityViewModel: ObservableObject {
    let learningWord: Word
    
    @Published var errorMessage: String?
    @Published var currentInstruction: Instruction?
    @Published var currentInstructionVoiceIndex: Int = 0
    
    private var instructions: [Instruction] {
        [
            VoiceResources.combineSyllablesActivityClosingInstruction()
        ]
    }
    
    let audioManager: AudioManager
    
    init(learningWord: Word) {
        self.learningWord = learningWord
        self.audioManager = AudioManager.shared
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
        playInstruction(nextInstruction)
    }
    
    private func playInstruction(_ instruction: Instruction) {
        self.currentInstruction = instruction
        let instructionVoices = instruction.voices
        audioManager.playQueue(instructionVoices, changeHandler: instructionVoiceChangeHandler)
    }
    
    private func instructionVoiceChangeHandler(_ queueCount: Int, _ newIndex: Int) {
        DispatchQueue.main.async {
            self.currentInstructionVoiceIndex = newIndex
        }
    }
}

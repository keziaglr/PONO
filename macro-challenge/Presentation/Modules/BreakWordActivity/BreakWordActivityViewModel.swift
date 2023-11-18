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
    
    func playInstruction(after: Bool = false) {
        //        guard !instructions.isEmpty else {
        //            return
        //        }
        //        guard let currentInstruction else {
        //            currentInstruction = instructions.first
        //            playInstruction(currentInstruction!)
        //            return
        //        }
        //        guard !isReplay else {
        //            playInstruction(currentInstruction)
        //            return
        //        }
        //        guard let currentIndex = instructions.firstIndex(where: { $0 == currentInstruction }) else {
        //            return
        //        }
        //        let nextInstructionIndex = currentIndex + 1
        //        guard let nextInstruction = instructions[safe: nextInstructionIndex] else {
        //            return
        //        }
        //        self.currentInstruction = nextInstruction
        //        playInstruction(nextInstruction)
        guard !instructions.isEmpty else {
            return
        }
        
        if !after{
            currentInstruction = instructions.first
        }else{
            currentInstruction = instructions.last
        }
        
        if let unwrappedInstruction = currentInstruction {
            playInstruction(unwrappedInstruction)
        }
    }
    
    private func playInstruction(_ instruction: Instruction) {
        let instructionVoices = instruction.voices
        audioManager.playQueue(instructionVoices, changeHandler: instructionVoiceChangeHandler)
    }
    
    private func instructionVoiceChangeHandler(_ queueCount: Int, _ newIndex: Int) {
        currentInstructionVoiceIndex = newIndex
    }
}

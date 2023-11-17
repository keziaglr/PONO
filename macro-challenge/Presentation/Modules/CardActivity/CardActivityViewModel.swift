//
//  CardActivityViewModel.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 15/11/23.
//

import SwiftUI
import AVFoundation

class CardActivityViewModel: ObservableObject {
    
    let learningWord: Word
    let syllableOrder: SyllableOrder
    
    private var syllable: Syllable? {
        syllableOrder == .firstSyllable ? learningWord.syllables[safe: 0] : syllableOrder == .secondSyllable ? learningWord.syllables[safe: 1] : nil
    }
    
    @Published var isCorrect: Bool?
    @Published var cameraPermission: Permission = .idle
    @Published var errorMessage: String?
    @Published var currentInstruction: Instruction?
    @Published var currentInstructionVoiceIndex: Int = 0
    
    private let syllables: [Syllable]
    private var instructions: [Instruction] {
        guard let syllable = syllable else { return [] }
        return [
            VoiceResources.cardActivityOpeningInstruction(syllable),
            VoiceResources.cardActivityClosingInstruction(syllable)
        ]
    }
    
    let audioManager: AudioManager
    @Published var qrScannerManager: QRScannerManager
    
    init(learningWord: Word, syllableOrder: SyllableOrder) {
        self.learningWord = learningWord
        self.syllableOrder = syllableOrder
        self.syllables = ContentManager.shared.syllables
        
        self.audioManager = AudioManager()
        
        self.qrScannerManager = QRScannerManager()
        self.qrScannerManager.delegate = self
        qrScannerManager.requestCameraAuthorizationIfNeeded { [weak self] permission in
            self?.playInstruction()
            if permission == .approved {
                self?.startScanning()
            }
        }
    }
    
    func playInstruction(isReplay: Bool = false) {
        guard !instructions.isEmpty else {
            return
        }
        guard let currentInstruction else {
            currentInstruction = instructions.first
            playInstruction(currentInstruction!)
            return
        }
        guard !isReplay else {
            playInstruction(currentInstruction)
            return
        }
        guard let currentIndex = instructions.firstIndex(where: { $0 == currentInstruction }) else {
            return
        }
        let nextInstructionIndex = currentIndex + 1
        guard let nextInstruction = instructions[safe: nextInstructionIndex] else {
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
    
    func startScanning() {
        self.qrScannerManager.setupCameraSession()
        if !(self.qrScannerManager.captureSession.isRunning) {
            DispatchQueue.global(qos: .background).async {
                self.qrScannerManager.captureSession.startRunning()
            }
        }
    }

    func stopScanning() {
        if self.qrScannerManager.captureSession.isRunning {
            self.qrScannerManager.captureSession.stopRunning()
        }
    }
    
    func isScannedCardCorrect(_ scannedCardSyllable: Syllable) -> Bool {
        return syllable?.id == scannedCardSyllable.id
    }
}

extension CardActivityViewModel: QRScannerDelegate {
    
    func getQrScannedDataDelegate(scannedData: String) {
        if let foundSyllable = syllables.first(where: { $0.id == UUID(uuidString: scannedData) }) {
            isCorrect = isScannedCardCorrect(foundSyllable)
            stopScanning()
            playInstruction()
        }
    }
    
}

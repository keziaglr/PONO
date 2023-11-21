//
//  PronunciationActivityViewModel.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 15/11/23.
//

import SwiftUI

class PronunciationActivityViewModel: ObservableObject {
    
    let learningWord: Word
    let syllableOrder: SyllableOrder?
    var syllable: Syllable? {
        syllableOrder == .firstSyllable ? learningWord.syllables[safe: 0] : syllableOrder == .secondSyllable ? learningWord.syllables[safe: 1] : nil
    }
    
    @Published var pronunciationStatus: PronunciationStatus = .idle {
        didSet {
            if pronunciationStatus == .correct || pronunciationStatus == .wrong {
                Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
                    self.isShowPlayRecording = true
                }
            }
        }
    }
    @Published var isShowPlayRecording: Bool = false
    @Published var isAudioRecordingAndRecognizing: Bool = false
    @Published var errorMessage: String?
    @Published var currentInstruction: Instruction?
    @Published var currentInstructionVoiceIndex: Int = 0
    @Published var duration: TimeInterval?
    
    private var instructions: [Instruction] {
        if syllableOrder != nil {
            guard let syllable = syllable else { return [] }
            return [
                VoiceResources.pronunciationActivityOpeningInstruction(syllable),
                VoiceResources.pronunciationActivityClosingInstruction()
            ]
        } else {
            return [
                VoiceResources.pronunciationActivityOpeningInstruction(learningWord),
                VoiceResources.pronunciationActivityClosingInstruction()
            ]
        }
    }
    
    private let audioManager: AudioManager
    private let recordingManager: RecordingManager
    private var soundClassifier: SoundClassifier?
    private var voiceRecognitionManager: VoiceRecognitionManager?
    private var bufferSize: Int = 0
    private var speechRecognizer = SpeechRecognitionManager()
    
    private var voiceRecord: AudioRecord?
    
    init(learningWord: Word, syllableOrder: SyllableOrder?) {
        self.learningWord = learningWord
        self.syllableOrder = syllableOrder
        
        audioManager = AudioManager()
        recordingManager = RecordingManager.shared
        soundClassifier = SoundClassifier(modelFileName: "sound_classification", delegate: self)
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
    
    func startVoiceRecognitionAndRecording() {
        guard pronunciationStatus == .idle else { return }
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { [weak self] _ in
            guard let self else { return }
            self.speechRecognizer.resetTranscript()
            self.speechRecognizer.startTranscribing()
            self.isAudioRecordingAndRecognizing = true
            self.pronunciationStatus = .recording
            
            self.recordingManager.startRecord(for: 4.0) { audioRecord in
                self.voiceRecord = audioRecord
                self.stopVoiceRecognitionAndRecording()
                self.stopSpeech()
                if self.pronunciationStatus != .correct {
                    self.pronunciationStatus = .wrong
                }
            }
            if syllableOrder != nil{
                self.startAudioRecognition()
            }
        }
    }
    
    func stopSpeech() {
        self.speechRecognizer.stopTranscribing()
        let text = String(self.speechRecognizer.transcript).lowercased()
        print(text)
        if !text.isEmpty{
            if (text.contains(learningWord.content) || learningWord.content.contains(text)) && syllableOrder == nil{
                playSoundCorrect()
                self.pronunciationStatus = .correct
            }else if (text.contains(syllable?.content ?? "") || ((syllable?.content.contains(text)) != nil)){
                playSoundCorrect()
                self.pronunciationStatus = .correct
            }
        }
        
    }
    
    func playSoundCorrect() {
        if pronunciationStatus != .correct{
            ContentManager.shared.playAudio("correct-answer", type: "wav")
        }
    }
    
    func retryVoiceRecognitionAndRecording() {
        isShowPlayRecording = false
        pronunciationStatus = .idle
        startVoiceRecognitionAndRecording()
    }
    
    func playWordOrSyllableSound() {
        if let syllable {
            audioManager.playQueue([syllable.content])
        } else {
            let audioFiles = learningWord.syllables.compactMap { $0.content }
            audioManager.playQueue(audioFiles)
        }
    }
    
    func playVoiceRecord() {
        guard let voiceRecord else { return }
        recordingManager.playRecording(voiceRecord) { duration in
            self.duration = duration
        }
    }
    
    private func startAudioRecognition() {
        guard let sampleRate = soundClassifier?.sampleRate else { return }
        
        voiceRecognitionManager = VoiceRecognitionManager(sampleRate: sampleRate)
        voiceRecognitionManager?.delegate = self
        
        bufferSize = voiceRecognitionManager?.bufferSize ?? 0
        
        voiceRecognitionManager?.checkPermissionsAndStartTappingMicrophone()
    }
    
    private func stopVoiceRecognitionAndRecording() {
        self.recordingManager.stopRecord()
        voiceRecognitionManager?.stopRecognize()
        self.isAudioRecordingAndRecognizing = false
    }
    
    private func runModel(inputBuffer: [Int16]) {
        soundClassifier?.start(inputBuffer: inputBuffer)
    }
    
    private func createProbabilityModel(_ probability: Float32, index: Int) -> ProbabilityModel? {
        if let labelName = soundClassifier?.labelNames[index] {
            return ProbabilityModel(labelName: labelName, probability: probability)
        }
        return nil
    }
    
    private func isAnyVoiceCorrect(_ probabilityModels: [ProbabilityModel]) -> Bool {
        (probabilityModels.first(where: { $0.labelName.lowercased() == syllable?.content.lowercased() })?.probability ?? 0.0) >= 0.7
    }
}

extension PronunciationActivityViewModel: VoiceRecognitionManagerDelegate {
    func voiceRecognitionManagerDidFailToAchievePermission(_ audioInputManager: VoiceRecognitionManager) {
        print("Microphone Permissions Denied")
    }
    
    func voiceRecognitionManager(_ audioInputManager: VoiceRecognitionManager, didCaptureChannelData channelData: [Int16]) {
        guard let sampleRate = soundClassifier?.sampleRate else { return }
        self.runModel(inputBuffer: Array(channelData[0..<sampleRate]))
        self.runModel(inputBuffer: Array(channelData[sampleRate..<bufferSize]))
    }
    
}

extension PronunciationActivityViewModel: SoundClassifierDelegate {
    
    func soundClassifier(_ soundClassifier: SoundClassifier, didInterpreteProbabilities probabilities: [Float32]) {
        var probabilityModels: [ProbabilityModel] = []
        for (index, probability) in probabilities.enumerated() {
            if let model = createProbabilityModel(probability, index: index) {
                probabilityModels.append(model)
            }
        }
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            if self.isAudioRecordingAndRecognizing,
               self.isAnyVoiceCorrect(probabilityModels) {
                playSoundCorrect()
                self.pronunciationStatus = .correct
                self.stopVoiceRecognitionAndRecording()
            }
        }
    }
    
}

struct ProbabilityModel: Identifiable {
    let id = UUID()
    let labelName: String
    let probability: Float32
}

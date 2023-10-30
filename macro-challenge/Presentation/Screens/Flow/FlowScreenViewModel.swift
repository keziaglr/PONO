//
//  SyllableViewModel.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 23/10/23.
//

import SwiftUI

class FlowScreenViewModel: ObservableObject, QrScannerDelegate {
    
    var am = AudioManager()
    var qrScannerManager: QrScannerManager = QrScannerManager()
    
    @Published var activity : Activity? = nil {
        didSet {
            getInstruction()
        }
    }
    @Published var type : TypeReading = .syllable1
    @Published var instruction : String = ""
    @Published var percent : CGFloat = 0.0
    @Published var scannedCard : Syllable?
    @Published var isCardFlipped = false
    
    private var stage = 0.12
    
    private var syllables: [Syllable] = []
    
    private(set) var word: Word? = nil
    
    init() {
        qrScannerManager.delegate = self
        self.getSyllables()
        self.getWord()
        self.activity = .beforeBreakWord
        self.getInstruction()
        
    }
    
    func setupQrScannerManager() {
    }
    
    func setActivity(act: Activity){
        print("settt \(act)")
        activity = act
    }
    
    func getAudioIndex() -> Int{
        return am.currentAudioIndex
    }
    
    func nextStep(){
        switch activity {
        case .beforeBreakWord:
            setActivity(act: .afterBreakWord)
            break
        case .afterBreakWord:
            setActivity(act: .beforeCard1)
            break
        case .beforeCard1:
            setActivity(act: .afterCard)
            break
        case .beforeCard2:
            setActivity(act: .afterCard)
            break
        case .afterCard:
            isScannedCardCorrect()
            break
        case .wrongCard:
            if type == .syllable1{
                setActivity(act: .beforeReadSyllable1)
            }else {
                setActivity(act: .beforeReadSyllable2)
            }
            break
        case .correctCard:
            if type == .syllable1{
                setActivity(act: .beforeReadSyllable1)
            }else {
                setActivity(act: .beforeReadSyllable2)
            }
            break
        case .beforeReadSyllable1:
            setActivity(act: .afterReadSyllable)
            break
        case .beforeReadSyllable2:
            setActivity(act: .afterReadSyllable)
            break
        case .beforeReadWord:
            setActivity(act: .afterReadWord)
            break
        case .afterReadSyllable:
            if type == .syllable2{
                type = .word
                setActivity(act: .beforeBlendWord)
            }else {
                type = .syllable2
                setActivity(act: .beforeCard2)
            }
            break
        case .afterReadWord:
            setActivity(act: .beforeBreakWord)
            break
        case .beforeBlendWord:
            setActivity(act: .afterBlendWord)
            break
        case .afterBlendWord:
            setActivity(act: .beforeReadWord)
            break
        case .none:
            instruction = ""
            break
        }
    }
    
    func getInstruction(){
        switch activity {
        case .beforeBreakWord:
            instruction = "Pecahkan kata ini"
            break
        case .afterBreakWord:
            instruction = "Selamat"
            percent += stage
            break
        case .beforeCard1:
            instruction = "Cari kartu yang sesuai dan tunjukkan ke kamera"
            break
        case .beforeCard2:
            instruction = "Cari kartu yang sesuai dan tunjukkan ke kamera"
            break
        case .afterCard:
            instruction = "Lihat hasil kartu"
            break
        case .wrongCard:
            instruction = "Coba lagi"
            percent += stage
            break
        case .correctCard:
            instruction = "Selamat"
            percent += stage
            break
        case .beforeReadSyllable1:
            instruction = ""
            break
        case .beforeReadSyllable2:
            instruction = ""
            break
        case .beforeReadWord:
            instruction = ""
            break
        case .afterReadSyllable:
            instruction = "Coba lagi"
            percent += stage
            break
        case .afterReadWord:
            instruction = "Coba lagi"
            percent += stage
            break
        case .beforeBlendWord:
            instruction = "Gabungkan kedua suku kata"
            break
        case .afterBlendWord:
            instruction = "Selamat"
            percent += stage
            break
        case .none:
            instruction = ""
            break
        }
    }
    
    func getSyllables() {
        syllables = ContentManager.shared.syllables
    }
    
    func getWord() {
        word = generateWord()
    }
    
    func generateWord() -> Word {
        if syllables.isEmpty {
            getSyllables()
        }

        let randomIndex1 = Int.random(in: 0..<syllables.count)
        var randomIndex2 = Int.random(in: 0..<syllables.count)

        while randomIndex2 == randomIndex1 {
            randomIndex2 = Int.random(in: 0..<syllables.count)
        }

        let syllable1 = syllables[randomIndex1]
        let syllable2 = syllables[randomIndex2]
        
        return Word(syllables: [syllable1, syllable2])
    }
    
    func soundSyllable(sound: [String]){
        am.playQueue(sound)
    }
    
    func tryAgain(){
        if activity == .wrongCard{
            setActivity(act: .beforeCard1)
            percent -= stage
        }else if activity == .afterReadSyllable {
            if type == .syllable1 {
                setActivity(act: .beforeReadSyllable1)
            }else{
                setActivity(act: .beforeReadSyllable2)
            }
            percent -= stage
        }else if activity == .afterReadWord{
            setActivity(act: .beforeReadWord)
            percent -= stage
        }
    }

    func playInstruction() {
        let syllable1 = (word?.syllable(at: 0))!
        let syllable2 = (word?.syllable(at: 1))!
        switch activity {
        case .beforeBreakWord:
            am.playQueue(["before_break-word(1)", syllable1, syllable2, "before_break-word(2)"])
            break
        case .afterBreakWord:
            am.playQueue(["after_break-word(1)", syllable1, syllable2, "after_break-word(2)", syllable1, "after_break-word(3)", syllable2])
            break
        case .beforeCard1:
            am.playQueue(["before_card(1)", syllable1,"before_card(2)"])
            break
        case .beforeCard2:
            am.playQueue(["before_card(1)", syllable2,"before_card(2)"])
            break
        case .afterCard:
            am.playQueue(["after_card(1)"])
            break
        case .wrongCard:
            am.playQueue(["after_card(2-wrong)"])
            break
        case .correctCard:
            am.playQueue(["after_card(2-correct)"])
            break
        case .beforeReadSyllable1:
            am.playQueue(["before_spelling", syllable1])
            break
        case .beforeReadSyllable2:
            am.playQueue(["before_spelling", syllable2])
            break
        case .beforeReadWord:
            am.playQueue(["before_spelling", syllable1, syllable2])
            break
        case .afterReadSyllable:
            am.playQueue(["after_spelling"])
            break
        case .afterReadWord:
            am.playQueue(["after_spelling"])
            break
        case .beforeBlendWord:
            am.playQueue(["before_blend-word"])
            break
        case .afterBlendWord:
            am.playQueue(["after_blend-word"])
            break
        case .none:
            break
        }
    }
}

extension FlowScreenViewModel {
    func getQrScannedDataDelegate(scannedData: String) {
        if let foundSyllable = syllables.first(where: { $0.id == UUID(uuidString: scannedData) }) {
            self.scannedCard = foundSyllable
            stopScanning()
            nextStep()
        } else {
            print("Card not exist")
        }
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
    
    func isScannedCardCorrect() {
        if scannedCard?.id == word?.syllables[0].id {
            print("Correct")
            setActivity(act: .correctCard)
        } else {
            print("INCORRECT")
            setActivity(act: .wrongCard)
        }
    }
}

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
    @Published var index = 0
    private var stage = 0.12
    private var level : Level = .easy
    private var syllables: [Syllable] = []
    private var words: [Word] = []

    private(set) var word: Word? = nil
    
    init() {
        qrScannerManager.delegate = self
        self.getSyllables()
        self.getWord()
        self.activity = .beforeBreakWord
        self.getInstruction()
        self.qrScannerManager.setupCameraSession()
    }
    
    func setActivity(act: Activity){
        activity = act
    }
    
    func getAudioIndex() -> Int{
        return am.currentAudioIndex
    }
    
    func nextStep(){
            switch self.activity {
            case .beforeBreakWord:
                self.setActivity(act: .afterBreakWord)
                break
            case .afterBreakWord:
                self.setActivity(act: .beforeCard1)
                break
            case .beforeCard1:
                self.setActivity(act: .afterCard)
                break
            case .beforeCard2:
                self.setActivity(act: .afterCard)
                break
            case .afterCard:
                self.isScannedCardCorrect()
                break
            case .wrongCard:
                if self.type == .syllable1{
                    self.setActivity(act: .beforeReadSyllable1)
                }else {
                    self.setActivity(act: .beforeReadSyllable2)
                }
                break
            case .correctCard:
                if self.type == .syllable1{
                    self.setActivity(act: .beforeReadSyllable1)
                }else {
                    self.setActivity(act: .beforeReadSyllable2)
                }
                break
            case .beforeReadSyllable1:
                self.setActivity(act: .afterReadSyllable)
                break
            case .beforeReadSyllable2:
                self.setActivity(act: .afterReadSyllable)
                break
            case .beforeReadWord:
                self.setActivity(act: .afterReadWord)
                break
            case .afterReadSyllable:
                if self.type == .syllable2{
                    self.type = .word
                    self.setActivity(act: .beforeBlendWord)
                }else {
                    self.type = .syllable2
                    self.setActivity(act: .beforeCard2)
                }
                break
            case .afterReadWord:
                nextLevel()
                self.getSyllables()
                self.getWord()
                self.stage = 0.12
                self.percent = self.stage
                self.type = .syllable1
                self.setActivity(act: .beforeBreakWord)
                break
            case .beforeBlendWord:
                self.setActivity(act: .afterBlendWord)
                break
            case .afterBlendWord:
                self.setActivity(act: .beforeReadWord)
                break
            case .none:
                self.instruction = ""
                break
            }
    }
    
    func nextLevel(){
        if level == .easy{
            level = .medium
        }else if level == .medium{
            level = .hard
        }else {
            level = .hard
        }
    }
    
    func getInstruction(){
        switch activity {
        case .beforeBreakWord:
            instruction = "Pecahkan kata ini"
            break
        case .afterBreakWord:
            instruction = "Selamat!"
            percent += stage
            break
        case .beforeCard1:
            instruction = "Cari kartu yang sesuai dan tunjukkan ke kamera"
            break
        case .beforeCard2:
            instruction = "Cari kartu yang sesuai dan tunjukkan ke kamera"
            break
        case .afterCard:
            instruction = "Lihat hasil"
            break
        case .wrongCard:
            instruction = "Coba lagi yuk!"
            percent += stage
            break
        case .correctCard:
            instruction = "Selamat!"
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
            instruction = ""
            percent += stage
            break
        case .afterReadWord:
            instruction = ""
            percent += stage
            break
        case .beforeBlendWord:
            instruction = "Gabungkan kedua suku kata"
            break
        case .afterBlendWord:
            instruction = "Selamat!"
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
    
    func getWords() {
        words = ContentManager.shared.words
    }
    
    func getWord() {
        word = generateWord()
    }
    
    func generateWord() -> Word {
        
        if words.isEmpty{
            getWords()
        }
        
        let word = Word(content: "", level: 0, syllables: [])
        
        if level == .easy{
            return  words.filter { $0.level == 0 }.randomElement() ?? word
        }else if level == .medium{
            return  words.filter { $0.level == 1 }.randomElement() ?? word
        }else if level == .hard{
            return  words.filter { $0.level == 2 }.randomElement() ?? word
        }
        
        return word
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
            am.playQueue(["before_break-word(1)", syllable1, syllable2, "before_break-word(2)"]) { idx in
                self.index = idx
            }
            break
        case .afterBreakWord:
            am.playQueue(["after_break-word(1)", syllable1, syllable2, "after_break-word(2)", syllable1, "after_break-word(3)", syllable2]){ idx in
                self.index = idx
            }
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
            am.playQueue(["before_pronunciation", syllable1])
            break
        case .beforeReadSyllable2:
            am.playQueue(["before_pronunciation", syllable2])
            break
        case .beforeReadWord:
            am.playQueue(["before_pronunciation", syllable1, syllable2])
            break
        case .afterReadSyllable:
            am.playQueue(["after_pronunciation(1)"])
            break
        case .afterReadWord:
            am.playQueue(["after_pronunciation(1)"])
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
        let wordSyllable = type == .syllable1 ? word?.syllables[0].id : word?.syllables[1].id
        if scannedCard?.id == wordSyllable {
            setActivity(act: .correctCard)
        } else {
            setActivity(act: .wrongCard)
        }
    }
}

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
//    let wordsList = [Word(syllables: Syllable(id: )]
    let wordsArray = [
        "baba",
        "babe",
        "babi",
        "babu",
        "bada",
        "bade",
        "badi",
        "bana",
        "bani",
        "banu",
        "bapa",
        "bebe",
        "bebi",
        "beda",
        "bedo",
        "bemo",
        "bena",
        "beni",
        "bibi",
        "bida",
        "bido",
        "bima",
        "bina",
        "bini",
        "bobo",
        "bodi",
        "bubo",
        "bubu",
        "bude",
        "budi",
        "budu",
        "bumi",
        "buna",
        "buni",
        "daba",
        "dada",
        "dadi",
        "dadu",
        "dame",
        "dami",
        "dana",
        "dapa",
        "debu",
        "demi",
        "demo",
        "dena",
        "depa",
        "dina",
        "dini",
        "dobi",
        "doni",
        "duda",
        "dudu",
        "dumi",
        "dupa",
        "mada",
        "madi",
        "mado",
        "madu",
        "mama",
        "mami",
        "mana",
        "mani",
        "mede",
        "medu",
        "memo",
        "meni",
        "menu",
        "midi",
        "mimi",
        "mina",
        "mini",
        "mode",
        "mono",
        "muda",
        "mumi",
        "muna",
        "muno",
        "nabi",
        "nabu",
        "nada",
        "nadi",
        "nama",
        "napi",
        "nini",
        "noda",
        "nona",
        "none",
        "noni",
        "pada",
        "padi",
        "padu",
        "pana",
        "panu",
        "papa",
        "papi",
        "peda",
        "pedu",
        "pena",
        "peni",
        "pepe",
        "pidi",
        "pipa",
        "pipi",
        "poma",
        "poni",
        "popi",
        "pudi",
        "puma",
        "pupa",
        "pupu"
    ]

    // Now you have an array called wordsArray containing the words you provided.

    
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
        print("settt \(act)")
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
    
    func getWord() {
        word = generateWord()
    }
    
    func generateWord() -> Word {
        if syllables.isEmpty {
            getSyllables()
        }
        let randomIndex1 = Int.random(in: 0..<syllables.count)
        var randomIndex2 = Int.random(in: 0..<syllables.count)
        if level == .easy{
            return Word(content: "", syllables: [syllables[randomIndex1], syllables[randomIndex1]])
        }else if level == .medium{
            while syllables[randomIndex1].letters[1] != syllables[randomIndex2].letters[1] || randomIndex1 == randomIndex2{
                randomIndex2 = Int.random(in: 0..<syllables.count)
            }
            
            return Word(content: "", syllables: [syllables[randomIndex1], syllables[randomIndex2]])
        }
        
        while randomIndex1 == randomIndex2 || syllables[randomIndex1].letters[1] == syllables[randomIndex2].letters[1]{
            randomIndex2 = Int.random(in: 0..<syllables.count)
        }
        
        return Word(content: "", syllables: [syllables[randomIndex1], syllables[randomIndex2]])
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

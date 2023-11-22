//
//  ReportViewModel.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 16/11/23.
//

import Foundation
import SwiftUI

enum SelectedComponent {
    case session
    case word
    case syllable
}

struct ReportButtonData {
    let component: SelectedComponent
    let title: String
    let iconName: String
}

class ReportViewModel: ObservableObject {
    @Published var word: PracticedWord?
    @Published var syllable: PracticedSyllable?
    @Published var isWord: Bool
    @Published var selectedComponent: SelectedComponent = .session
    let reportManager: ReportManager
    @Published var practices : [Practice] = []
    @Published var words : [PracticedWord] = []
    @Published var syllables : [PracticedSyllable] = []
    
    let buttonData : [ReportButtonData] = [
        ReportButtonData(component: .session, title: "total latihan", iconName: "Hourglass"),
        ReportButtonData(component: .word, title: "kata dipelajari", iconName: "puzzle"),
        ReportButtonData(component: .syllable, title: "suku kata dipelajari", iconName: "book")
    ]
    
    init(word: PracticedWord? = nil, syllable: PracticedSyllable? = nil) {
        isWord = syllable == nil
        self.word = word
        self.syllable = syllable
        self.reportManager = ReportManager.shared
        Task{
            await getPractices()
            await getWords()
            await getSyllables()
        }
    }
    
    func getPractices() async {
        practices = await reportManager.getPractices()
    }
    
    func getWords() async {
        words = await reportManager.getPracticedWords()
        
    }
    
    func getSyllables() async {
        syllables = await reportManager.getPracticedSyllables()
    }
    
    func fetchPracticesTotal() -> Int {
        return practices.count // Static value for session total
    }
    
    func fetchSyllablesTotal() -> Int {
        return syllables.count // Static value for session total
    }
    
    func fetchWordsTotal() -> Int {
        return words.count // Static value for session total
    }
    
    
    func fetchTotal(for component: SelectedComponent) -> Int {
        switch self.selectedComponent {
        case .session:
            return practices.count // Static value for session total
        case .syllable:
            return syllables.count // Static value for syllable total
        case .word:
            return words.count  // Static value for word total
        }
    }
    
    func changeSelectedComponent(to component: SelectedComponent) {
        selectedComponent = component
    }
    
    func newCalculateRating() -> Int {
        //Calculate persentage P & C
        guard let syllable else {
            return -1
        }
        let pronouncePercentage = calculateSuccessPercentage(successCount: Int(syllable.countPronunciationCorrect), totalAttempts: syllable.totalPractices)
        let cardPercentage = calculateSuccessPercentage(successCount: Int(syllable.countCardRecognizeCorrect), totalAttempts: syllable.totalPractices)
        
        //Cek practice < 10 -> return default
        if syllable.totalPractices < 10 {
            return 0
        }
        //Cek (P) true && (C) true < 65% -> return 1
        else if (pronouncePercentage < 65) && (cardPercentage < 65) {
            return 1
        }
        //Cek (P) true && (C) true >= 65% -> return 3
        else if (pronouncePercentage >= 65) && (cardPercentage >= 65) {
            return 3
        }
        //Cek (P) true || (C) true >= 65% -> return 2
        else if (pronouncePercentage >= 65) || (cardPercentage >= 65) {
            return 2
        }
        else {
            return 0
        }
    }
    
    func getText() -> String{
        if isWord {
            guard let word else { return "" }
            return word.id ?? ""
        } else {
            guard let syllable else { return "" }
            return syllable.content ?? ""
        }
    }
    
    func getCondition() -> CardReportType {
        if isWord{
            guard let word else {
                return .empty
            }
            
            if word.totalPractices < 10 {
                return .empty
            } else if calculateSuccessPercentage(successCount: Int(word.countPronunciationCorrect), totalAttempts: word.totalPractices) >= 65 {
                return .success
            } else {
                return .fail
            }
        } else {
            guard let syllable else {
                return .empty
            }
            
            if syllable.totalPractices < 10 {
                return .empty
            }
            
            let pronouncePercentage = calculateSuccessPercentage(successCount: Int(syllable.countPronunciationCorrect), totalAttempts: syllable.totalPractices)
            let cardPercentage = calculateSuccessPercentage(successCount: Int(syllable.countCardRecognizeCorrect), totalAttempts: syllable.totalPractices)
            
            if (pronouncePercentage < 65) && (cardPercentage < 65) {
                return .fail
            }
            else if (pronouncePercentage >= 65) && (cardPercentage >= 65) {
                return .success
            }
            else if (pronouncePercentage >= 65) || (cardPercentage >= 65) {
                return .success
            }
            
        }
        return .empty
    }
    
    func getTextColor() -> Color {
        switch getCondition() {
        case .fail:
            return Color.Red2
        case .success:
            return Color.Green2
        case .empty:
            return Color.Grey4
        }
    }
    
    func getTextColorWords() -> Color {
        switch getCondition() {
        case .success:
            return Color.Green1
        case .fail:
            return Color.Red2
        case .empty:
            return Color.Grey4
        }
    }
    
    func getDescriptionSucceedAttempts() -> String {
        var count = 0
        if isWord {
            guard let word else { return "" }
            count = word.totalPractices
        } else {
            guard let syllable else { return "" }
            count = syllable.totalPractices
        }
        
        if count < 10 {
            return "Belum mencapai 10x"
        } else {
            return "Berhasil \(count)x"
        }
    }
    
    func getTotalAttempts() -> Int{
        if isWord {
            guard let word else { return -1 }
            return word.totalPractices
        } else {
            guard let syllable else { return -1 }
            return syllable.totalPractices
        }
    }
    
    func getDescription() -> String {
        switch getCondition() {
        case .success:
            return "Kemajuan yang luar biasa!"
        case .fail:
            return "Masih perlu latihan lagi!"
        case .empty:
            return "Analitik kata belum dapat dibuka"
        }
    }
    
    func getBackgroundColor() -> Color {
        switch getCondition() {
        case .fail:
            return Color.Red2
        case .success:
            return Color.Green2
        default:
            return Color.White1
        }
    }
    
    func calculateSuccessPercentage(successCount: Int, totalAttempts: Int) -> Float {
        guard totalAttempts > 0 else {
            return 0.0
        }
        
        let successRate = (Float(successCount) / Float(totalAttempts)) * 100
        return successRate
    }
    
}


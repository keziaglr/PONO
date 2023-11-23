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
            await getPracticeData()
        }
        refreshData()
    }
    
    private var counts : [Double] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    @Published var data: [SessionData] = []
    @Published var average : Int = 0
    let manager = ReportManager.shared
    
    private func getAverage() {
        average = Int(counts.reduce(0, +) / Double(counts.count))
    }
    
    private func refreshData(){
        data.removeAll()
        for (index, count) in counts.enumerated() {
            let dayOfWeek = getDayOfWeek(index + 1)
            let sessionData = SessionData(type: dayOfWeek, count: count)
            data.append(sessionData)
        }
        getAverage()
    }
    
    private func getDayOfWeek(_ index: Int) -> String {
        switch index {
        case 1: return "Sen"
        case 2: return "Sel"
        case 3: return "Rab"
        case 4: return "Kam"
        case 5: return "Jum"
        case 6: return "Sab"
        case 7: return "Min"
        default: return ""
        }
    }
    
    private func getWeek() -> [String] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let dayOfWeek = calendar.component(.weekday, from: today)
        let dates = calendar.range(of: .weekday, in: .weekOfYear, for: today)!
            .compactMap { calendar.date(byAdding: .day, value: $0 - (dayOfWeek - 1), to: today) }
        
        let formattedDates = dates.map { formatDate($0, format: "yyyy-MM-dd") }
        
        return formattedDates
    }
    
    private func formatDate(_ date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    func getPracticeData() async {
        let practices = await manager.getPractices()
        let dates = getWeek()
        
        for index in 0..<7 {
            let practicesForDate = practices.filter { practice in
                guard let createdDate = practice.createdAt else {
                    return false
                }
                let formattedDate = formatDate(createdDate, format: "yyyy-MM-dd")
                return formattedDate == dates[index]
            }
            
            // Count the practices for the current date
            let practiceCountForDate = practicesForDate.count
            data[index].count = Double(practiceCountForDate)
            
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
    
    func getDescCondition(isPronunciation: Bool = true) -> CardReportType {
        if isWord {
            return getCondition()
        } else {
            guard let syllable else { return .empty }
            if syllable.totalPractices < 10 {
                return .empty
            }
            return calculateSuccessPercentage(successCount: isPronunciation ? Int(syllable.countPronunciationCorrect) : Int(syllable.countCardRecognizeCorrect), totalAttempts: syllable.totalPractices) < 65 ? .fail : .success
        }
    }
    
    func getTextColor(isPronunciation: Bool = true) -> Color {
        switch getDescCondition(isPronunciation: isPronunciation) {
        case .fail:
            return Color.Red2
        case .success:
            return Color.Green1
        case .empty:
            return Color.Grey4
        }
    }
    
    func getDescriptionSucceedAttempts(isPronunciation: Bool = true) -> String {
        var count = 0
        var correct = 0
        if isWord {
            guard let word else { return "" }
            count = word.totalPractices
            correct = Int(word.countPronunciationCorrect)
        } else {
            guard let syllable else { return "" }
            count = syllable.totalPractices
            correct = Int(isPronunciation ? syllable.countPronunciationCorrect : syllable.countCardRecognizeCorrect)
        }
        
        if count < 10 {
            return "Belum mencapai 10x"
        } else {
            return "Berhasil \(correct)x"
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
    
    func getDescription(isPronunciation: Bool = true) -> String {
        switch getDescCondition(isPronunciation: isPronunciation) {
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


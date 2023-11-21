//
//  ReportViewModel.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 16/11/23.
//

import Foundation


enum SelectedComponent {
    case session
    case syllable
    case word
}

struct ReportButtonData {
    let component: SelectedComponent
    let title: String
    let iconName: String
}

class ReportViewModel: ObservableObject {
    @Published var selectedComponent: SelectedComponent = .session
//    @Published var isClicked: Bool
//    @Published var is
    @Published var isNoSessionStarted: Bool
    @Published var isFlipped: Bool
    
    let buttonData : [ReportButtonData] = [
        ReportButtonData(component: .session, title: "total sesi", iconName: "hourglass"),
        ReportButtonData(component: .syllable, title: "suku kata dipelajari", iconName: "book"),
        ReportButtonData(component: .word, title: "kata dipelajari", iconName: "puzzle")
    ]
    
    init(selectedComponent: SelectedComponent, /*isClicked: Bool,*/ isNoSessionStarted: Bool, isFlipped: Bool) {
        self.selectedComponent = selectedComponent
//        self.isClicked = isClicked
        self.isNoSessionStarted = isNoSessionStarted
        self.isFlipped = isFlipped
    }

    
    func fetchTotal(for component: SelectedComponent) -> Int {
            switch component {
            case .session:
                return 50 // Static value for session total
            case .syllable:
                return 30 // Static value for syllable total
            case .word:
                return 40 // Static value for word total
            }
        }
    
    func changeSelectedComponent(to component: SelectedComponent) {
        selectedComponent = component
    }
    
}


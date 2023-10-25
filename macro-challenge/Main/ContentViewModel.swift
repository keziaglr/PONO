//
//  ContentViewModel.swift
//  macro-challenge
//
//  Created by Rio Johanes Sumolang on 25/10/23.
//

import SwiftUI
import Foundation

class ContentViewModel : ObservableObject{
    var audioManager = RecordingManager.shared
    
    func startTest() {
        audioManager.startRecord { [weak self] record in
            guard self != nil else { return }
        }
    }
    
    func stopTest() {
        audioManager.stopRecord()
    }
}

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
    
    var tempRec: AudioRecord?
    
    func startRecord() {
        audioManager.startRecord { [weak self] record in
            guard let self else { return }
            self.tempRec = record
        }
    }
    
    func stopRecord() {
        audioManager.stopRecord()
    }
    
    func startPlaying() {
        guard let tempRec else { return }
        
        audioManager.playRecording(tempRec)
    }
}

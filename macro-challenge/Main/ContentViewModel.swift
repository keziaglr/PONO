//
//  ContentViewModel.swift
//  macro-challenge
//
//  Created by Rio Johanes Sumolang on 27/10/23.
//

import Foundation
import AVFoundation

class ContentViewModel : NSObject {
    var audioManager: AudioManager = AudioManager()
    var audioFileNames: [String] = ["before_spelling", "ma"]
    
    func playAudio() {
        audioManager.playQueue(audioFileNames)
    }
}

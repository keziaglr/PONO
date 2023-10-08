//
//  MusicController.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 04/05/23.
//

import SwiftUI
import AVFoundation

class MusicController: ObservableObject{
    @Published var audioPlayer: AVAudioPlayer?
    func playSound() {
        guard let url = Bundle.main.url(forResource: "BUKU", withExtension: "m4a") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
            audioPlayer?.setVolume(1, fadeDuration: 0.5)
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

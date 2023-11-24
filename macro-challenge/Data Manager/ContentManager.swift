//
//  ContentManager.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 23/10/23.
//

import Foundation
import AVFoundation

class ContentManager {
    static let shared = ContentManager()
    
    var audioPlayer: AVAudioPlayer
    
    private let serialQueue = DispatchQueue(label: "SoundQueue", qos: .userInitiated)
    
    private init() {
        audioPlayer = AVAudioPlayer()
    }
    
    lazy var words: [Word] = {
        getWordsData()
    }()
    
    lazy var syllables: [Syllable] = {
        getSyllablesData()
    }()
    
    private func getSyllablesData() -> [Syllable] {
        if let url = Bundle.main.url(forResource: "syllables", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                return try JSONDecoder().decode([Syllable].self, from: data)
            } catch {
                return []
            }
        }
        return []
    }
    
    private func getWordsData() -> [Word] {
        if let url = Bundle.main.url(forResource: "words", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                return try JSONDecoder().decode([Word].self, from: data)
            } catch {
                return []
            }
        }
        return []
    }
    
    func playSyllableSound(_ syllable: Syllable) {
        playAudio(syllable.content)
    }
    
    func playAudio(_ assetName: String, type: String = "mp3") {
        guard let path = Bundle.main.path(forResource: assetName, ofType: type) else {return}
        let url = URL(fileURLWithPath: path)
        
        do {
            try serialQueue.sync {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer.play()
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func stopAudio(){
        audioPlayer.stop()
    }
}


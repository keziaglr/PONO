//
//  ContentManager.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 23/10/23.
//

import Foundation
import AVFoundation

//protocol ContentManagerProtocol {
//    func playInstruction(_ instruction: Instruction)
//    func playSyllableAudio(_ syllable: Syllable)
//    func playWordAudio(_ word: Word)
//    func getWord() -> Word
//    func getSyllable() -> Syllable
//}
//
//enum Instruction {
//    case welcome
//    case learnWord([Syllable])
//}
//
//class InstructionContent {
//    func playInstruction(_ instruction: Instruction) {
//        switch instruction {
//        case .welcome:
//            break
//        case .learnWord(let array):
//            let inst = array.compactMap { $0.audioURL }
//            playQueueAudio(inst)
//        }
//    }
//
//    private func playQueueAudio(_ audioURLs: [URL]) {
////                let playerItems = audioURLs.map { AVPlayerItem(url: $0) }
//        // Buat dispatch group untuk memantau pemutaran audio
//        let dispatchGroup = DispatchGroup()
//
//        // Buat dispatch queue untuk menjalankan pemutaran audio secara asynchronous
//        let queue = DispatchQueue.global(qos: .userInteractive)
//
//        // Loop melalui setiap URL audio dan mainkan secara parallel
//        for audioURL in audioURLs {
//            dispatchGroup.enter() // Masukkan dispatch group sebelum memulai pemutaran audio
//
//            // Jalankan pemutaran audio secara asynchronous
//            queue.async {
//                ContentManager.playAudio(audioURLs[1])
//
//                // Tandai keluar dari dispatch group setelah audio selesai diputar
//                player.addBoundaryTimeObserver(forTimes: [NSValue(time: CMTimeAdd(playerItem.duration, CMTimeMake(value: 1, timescale: 1)))], queue: DispatchQueue.main) {
//                    dispatchGroup.leave()
//                }
//            }
//        }
//    }
//}

class ContentManager {
    static let shared = ContentManager()
    
    var audioPlayer: AVAudioPlayer!
    
    private init() {}
    
    private var _syllables: [Syllable] = []
    
    var syllables: [Syllable] {
        if _syllables.isEmpty {
            _syllables = getSyllablesData()
        }
        return _syllables
    }
    
    private func getSyllablesData() -> [Syllable] {
        if let url = Bundle.main.url(forResource: "syllables", withExtension: "json") {
            do {
                let data =  try Data(contentsOf: url)
                return try JSONDecoder().decode([Syllable].self, from: data)
            } catch {
                return []
            }
        }
        return []
    }
    
    func playAudio(_ assetName: String) {
        
        guard let path = Bundle.main.path(forResource: assetName, ofType: "m4a") else {return}
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func stopAudio(){
        audioPlayer?.stop()
    }
}

//
//  AudioManager.swift
//  macro-challenge
//
//  Created by Rio Johanes Sumolang on 29/10/23.
//

import AVFoundation

class AudioManager: NSObject {
    var queuePlayer: AVQueuePlayer?
    var playerItems: [AVPlayerItem] = []
    var currentAudioIndex = 0
    
    var queueDidChange: ((_ index: Int) -> Void)?
    
    func playQueue(_ audios: [String], changeHandler: ((_ index: Int) -> Void)? = nil) {
        queueDidChange = changeHandler
        setupAudioFiles(audios)
        queuePlayer?.play()
    }
    
    private func setupAudioFiles(_ audios: [String]) {
        queuePlayer?.removeObserver(self, forKeyPath: "currentItem")
        playerItems.removeAll()
        for audioFileName in audios {
            if let path = Bundle.main.path(forResource: audioFileName, ofType: "m4a") {
                let url = URL(fileURLWithPath: path)
                let playerItem = AVPlayerItem(url: url)
                playerItems.append(playerItem)
            }
        }
        
        queuePlayer = AVQueuePlayer(items: playerItems)
        
        queuePlayer?.self.addObserver(self, forKeyPath: "currentItem", options: [.new, .initial], context: nil)
    }
    
    // Optional: observe player item changes
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem", let player = queuePlayer {
            if let currentItem = player.currentItem, let index = playerItems.firstIndex(of: currentItem) {
                currentAudioIndex = index
                queueDidChange?(index)
            }
        }
    }
}

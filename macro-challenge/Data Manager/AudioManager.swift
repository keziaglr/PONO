import AVFoundation

class AudioManager: NSObject {
    var queuePlayer: AVQueuePlayer?
    var playerItems: [AVPlayerItem] = []
//    var audioFileNames: [String] = ["after_spelling", "before_spelling"]
    var currentAudioIndex = 0
//    guard let path = Bundle.main.path(forResource: assetName, ofType: "m4a") else {return}
//    let url = URL(fileURLWithPath: path)
    override init() {
        // Create player items from audio file names
//        for audioFileName in audioFileNames {
//            if let path = Bundle.main.path(forResource: audioFileName, ofType: "m4a") {
//                let url = URL(fileURLWithPath: path)
//                let playerItem = AVPlayerItem(url: url)
//                playerItems.append(playerItem)
//                print("WOIWOI-> ITEM \(url.absoluteString)")
//            }
//        }
        
        // Initialize AVQueuePlayer with the player items
//        queuePlayer = AVQueuePlayer(items: playerItems)
        super.init()
        // Observe player item changes (optional)
//        queuePlayer?.self.addObserver(self, forKeyPath: "currentItem", options: [.new, .initial], context: nil)
        
    }
    
    func playQueue(_ audios: [String]) {
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
            }
        }
    }
}

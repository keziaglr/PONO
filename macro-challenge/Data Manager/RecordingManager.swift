//
//  AudioManager.swift
//  macro-challenge
//
//  Created by Rio Johanes Sumolang on 25/10/23.
//

import AVFoundation

protocol RecordManagerProtocol {
    func recordVoiceAudio(completion: @escaping (AudioRecord) -> Void)
    func playVoiceAudio(_ file: AudioRecord)
}

class RecordingManager: NSObject {
    
    static let shared = RecordingManager()
    
    private override init() {}
    
    var record: AudioRecord? = nil
    
    private var audioRecorder: AVAudioRecorder?
    private var audioPlayer: AVAudioPlayer?
    private var isRecording: Bool = false
    private var timer: Timer?
    
    deinit {
        timer?.invalidate()
        deleteRecord()
    }
    
    func startRecord(for seconds: TimeInterval = 5, completion: @escaping (AudioRecord) -> Void) {
        let recordingSession = AVAudioSession.sharedInstance()
        var timerSeconds = seconds
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Cannot setup the Recording")
        }
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = path.appendingPathComponent("\(Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss")).m4a")
        
        let settings = [
            AVFormatIDKey: Int(1819304813),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
            audioRecorder?.prepareToRecord()
            audioRecorder?.record()
            isRecording = true
            
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (value) in
                timerSeconds -= 1
                if timerSeconds == 0 {
                    self?.stopRecord()
                    self?.timer?.invalidate()
                    
                    if let url = self?.audioRecorder?.url {
                        let audioRecord = AudioRecord(url: url, createdAt: .now)
                        self?.record = audioRecord
                        completion(audioRecord)
                    }
                }
            })
            
        } catch {
            print("Failed to Setup the Recording")
        }
    }
    
    func stopRecord(){
        audioRecorder?.stop()
        isRecording = false
    }
    
    func playRecording(_ record: AudioRecord, completion: ((_ duration: TimeInterval?) -> Void)? = nil) {
        let url = record.url
        
        let playSession = AVAudioSession.sharedInstance()
        
        do {
            try playSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing failed in Device")
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.volume = 10.0
            audioPlayer?.play()
            completion?(audioPlayer?.duration)
        } catch {
            print("Playing Failed")
        }
    }
    
    func stopPlaying() {
        audioPlayer?.stop()
    }
    
    func deleteRecord() {
        do {
            try FileManager.default.removeItem(at: record!.url)
        } catch {
            print("Can't delete")
        }
    }
}

extension RecordingManager: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    }
}

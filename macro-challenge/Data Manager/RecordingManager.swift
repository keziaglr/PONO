//
//  AudioManager.swift
//  macro-challenge
//
//  Created by Rio Johanes Sumolang on 25/10/23.
//

import Foundation
import AVFoundation

protocol RecordManagerProtocol {
    func recordVoiceAudio(completion: @escaping (AudioRecord) -> Void)
    func playVoiceAudio(_ file: AudioRecord)
}

class RecordingManager: NSObject {
    
    static let shared = RecordingManager()
    
    var records: [AudioRecord] = []
    
    private var audioRecorder: AVAudioRecorder?
    private var audioPlayer: AVAudioPlayer?
    private var isRecording: Bool = false
    private var timer: Timer?
    
    override init() {
        super.init()
        
    }
    
    deinit {
        // Invalidate timer
        timer?.invalidate()
        
        // Remove recording file
        deleteRecords()
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
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
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
                        let recording = AudioRecord(url: url, createdAt: .now)
                        self?.records.append(recording)
                        completion(recording)
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
    
    func playRecording(_ record: AudioRecord) {
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
            audioPlayer?.play()
        } catch {
            print("Playing Failed")
        }
    }
    
    func stopPlaying() {
        audioPlayer?.stop()
    }
    
    func deleteRecords() {
        for record in records {
            do {
                try FileManager.default.removeItem(at: record.url)
            } catch {
                print("Can't delete")
            }
        }
    }
    
    func deleteRecord(_ record: AudioRecord) {
        do {
            try FileManager.default.removeItem(at: record.url)
        } catch {
            print("Can't delete")
        }
    }
}

extension RecordingManager: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    }
}

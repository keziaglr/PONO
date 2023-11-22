//
//  VoiceRecognitionManager.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 15/11/23.
//

import AVFoundation

public protocol VoiceRecognitionManagerDelegate: AnyObject {
    func voiceRecognitionManagerDidFailToAchievePermission(_ manager: VoiceRecognitionManager)
    func voiceRecognitionManager(_ manager: VoiceRecognitionManager, didCaptureChannelData channelData: [Int16])
}

public class VoiceRecognitionManager {
    // MARK: - Constants
    public let bufferSize: Int
    
    private let sampleRate: Int
    private let conversionQueue = DispatchQueue(label: "conversionQueue")
    
    // MARK: - Variables
    public weak var delegate: VoiceRecognitionManagerDelegate?
    
    private var audioEngine = AVAudioEngine()
    
    // MARK: - Methods
    
    public init(sampleRate: Int) {
        self.sampleRate = sampleRate
        self.bufferSize = sampleRate * 2
    }
    
    static func requestPermissions(completion: ((Bool) -> Void)? = nil) {
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            completion(granted)
        }
    }
    
    public func checkPermissionsAndStartTappingMicrophone() {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .granted:
            startRecognize()
        case .denied:
            delegate?.voiceRecognitionManagerDidFailToAchievePermission(self)
        case .undetermined:
            requestPermissions { granted in
                if granted {
                    self.startRecognize()
                } else {
                    self.checkPermissionsAndStartTappingMicrophone()
                }
            }
        @unknown default:
            fatalError()
        }
    }
    
    /// Starts tapping the microphone input and converts it into the format for which the model is trained and
    /// periodically returns it in the block
    public func startRecognize() {
        let inputNode = audioEngine.inputNode
        let inputFormat = inputNode.outputFormat(forBus: 0)
        guard let recordingFormat = AVAudioFormat(
            commonFormat: .pcmFormatInt16,
            sampleRate: Double(sampleRate),
            channels: 1,
            interleaved: true
        ), let formatConverter = AVAudioConverter(from:inputFormat, to: recordingFormat) else { return }
        
        // installs a tap on the audio engine and specifying the buffer size and the input format.
        inputNode.installTap(onBus: 0, bufferSize: AVAudioFrameCount(bufferSize), format: inputFormat) {
            buffer, _ in
            
            self.conversionQueue.async {
                // An AVAudioConverter is used to convert the microphone input to the format required
                // for the model.(pcm 16)
                guard let pcmBuffer = AVAudioPCMBuffer(
                    pcmFormat: recordingFormat,
                    frameCapacity: AVAudioFrameCount(recordingFormat.sampleRate * 2.0)
                ) else { return }
                
                var error: NSError?
                let inputBlock: AVAudioConverterInputBlock = { _, outStatus in
                    outStatus.pointee = AVAudioConverterInputStatus.haveData
                    return buffer
                }
                
                formatConverter.convert(to: pcmBuffer, error: &error, withInputFrom: inputBlock)
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let channelData = pcmBuffer.int16ChannelData {
                    let channelDataValue = channelData.pointee
                    let channelDataValueArray = stride(
                        from: 0,
                        to: Int(pcmBuffer.frameLength),
                        by: buffer.stride
                    ).map { channelDataValue[$0] }
                    
                    // Converted pcm 16 values are delegated to the controller.
                    self.delegate?.voiceRecognitionManager(self, didCaptureChannelData: channelDataValueArray)
                }
            }
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func stopRecognize() {
        audioEngine.stop()
    }
    
}

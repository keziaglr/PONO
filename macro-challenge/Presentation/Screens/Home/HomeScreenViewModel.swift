//
//  HomeScreenViewModel.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 09/11/23.
//

import AVFoundation
import Speech

class HomeScreenViewModel: ObservableObject {
    func requestAllPermission() {
        Task {
            VoiceRecognitionManager.requestPermissions()
            await AVAudioSession.sharedInstance().hasPermissionToRecord()
            await SFSpeechRecognizer.hasAuthorizationToRecognize()
            QRScannerManager.requestCameraAuthorizationIfNeeded(completion: { permission in })
        }
    }
}

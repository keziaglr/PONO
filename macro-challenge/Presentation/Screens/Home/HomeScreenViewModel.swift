//
//  HomeScreenViewModel.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 09/11/23.
//

import Foundation


class HomeScreenViewModel: ObservableObject {
    func requestAllPermission() {
        Task {
            VoiceRecognitionManager.requestPermissions()
            AVAudioSession.hasPermissionToRecord()
            SFSpeechRecognizer.hasAuthorizationToRecognize()
            QRScannerManager.requestCameraAuthorizationIfNeeded(completion: { permission in })
        }
    }
}

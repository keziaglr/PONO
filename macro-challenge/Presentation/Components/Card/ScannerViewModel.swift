//
//  ScannerViewModel.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 26/10/23.
//

import Foundation
import AVFoundation

class ScannerViewModel: ObservableObject , QrScannerDelegate{
    
    init() {
        qrScannerManager = QrScannerManager()
        qrScannerManager.delegate = self
    }
    
    @Published var scannedData = "AA"
    var qrScannerManager: QrScannerManager

    func startScanning() {
        
        self.qrScannerManager.setupCameraSession()
        if !self.qrScannerManager.captureSession.isRunning {
            DispatchQueue.global(qos: .background).async {
                self.qrScannerManager.captureSession.startRunning()
            }
        }
    }

    func stopScanning() {
        if self.qrScannerManager.captureSession.isRunning {
            self.qrScannerManager.captureSession.stopRunning()
        }
    }
    
    
    func getQrScannedDataDelegate(scannedData: String) {
        self.scannedData = scannedData
    }
    
}

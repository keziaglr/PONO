//
//  QRScannerManager.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 26/10/23.
//

import AVKit
import SwiftUI

protocol QRScannerDelegate : AnyObject {
    func getQrScannedDataDelegate(scannedData: String)
}

class QRScannerManager: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    
    weak var delegate: QRScannerDelegate?
    
    var captureSession: AVCaptureSession = .init()
    private var qrOutput: AVCaptureMetadataOutput = .init()
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metaObject = metadataObjects.first {
            guard let readableObject = metaObject as? AVMetadataMachineReadableCodeObject else {
                return
            }
            guard let code = readableObject.stringValue else { return }
            delegate?.getQrScannedDataDelegate(scannedData: code)
        }
    }
    
    func requestCameraAuthorizationIfNeeded(completion: @escaping (Permission) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            return completion(.approved)
            
        case .notDetermined:
            Task {
                if await AVCaptureDevice.requestAccess(for: .video) {
                    return completion(.approved)
                } else {
                    return completion(.idle)
                }
            }
            
        case .denied, .restricted:
            return completion(.denied)
            
        default:
            return completion(.idle)
        }
    }
    
    func setupCameraSession() {
        do {
            guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .front).devices.first else {
                print("Error Devices")
                return
            }
            
            let input = try AVCaptureDeviceInput(device: device)
            
            guard self.captureSession.canAddInput(input), self.captureSession.canAddOutput(qrOutput) else {
                print("Error input output")
                return
            }
            self.captureSession.sessionPreset = .high
            self.captureSession.beginConfiguration()
            self.captureSession.addInput(input)
            self.captureSession.addOutput(self.qrOutput)
            self.qrOutput.metadataObjectTypes = [.qr]
            self.qrOutput.setMetadataObjectsDelegate(self, queue: .main)
            self.captureSession.commitConfiguration()
            
        } catch {
            print("Error prepare camera \(error.localizedDescription)")
        }
    }

}

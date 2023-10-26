//
//  QrScannerManager.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 26/10/23.
//

import AVKit
import SwiftUI

class QrScannerManager: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    
    
    weak var delegate: QrScannerDelegate?
    
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

protocol QrScannerDelegate : AnyObject {
    func getQrScannedDataDelegate(scannedData: String)
}

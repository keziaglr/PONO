//
//  QrCameraView.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 26/10/23.
//

import SwiftUI
import AVKit

struct QrCameraView: UIViewRepresentable {
    var cameraSession: AVCaptureSession
    var frameSize: CGSize
    
    func makeUIView(context: Context) -> UIView {
        let view = UIViewType(frame: CGRect(origin: .zero, size: frameSize))
        view.backgroundColor = .clear
        
        let cameraLayer = AVCaptureVideoPreviewLayer(session: cameraSession)
        cameraLayer.frame = view.bounds
        if let connection = cameraLayer.connection {
            print("laksdjfa")
            connection.videoOrientation = .portrait
        }
        cameraLayer.videoGravity = .resizeAspectFill
        print("dataaa \(cameraLayer.connection?.isVideoOrientationSupported) |\(cameraLayer.connection?.videoOrientation.rawValue.description)")
        cameraLayer.masksToBounds = true
        view.layer.addSublayer(cameraLayer)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

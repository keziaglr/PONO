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
        cameraLayer.frame = CGRect(origin: .zero, size: frameSize)
        if let connection = cameraLayer.connection {
            connection.videoOrientation = .landscapeRight
        }
        cameraLayer.videoGravity = .resizeAspect
        cameraLayer.masksToBounds = true
        view.layer.addSublayer(cameraLayer)
        view.contentMode = .scaleAspectFit
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

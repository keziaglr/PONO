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
        cameraLayer.videoGravity = .resizeAspectFill
        cameraLayer.masksToBounds = true
        view.layer.addSublayer(cameraLayer)
        view.contentMode = .scaleAspectFit
        print("qwerqwer Orientation -> \(UIDevice.current.orientation)")
        if let connection = cameraLayer.connection {
            connection.videoOrientation = .landscapeRight
        }
        NotificationCenter.default.addObserver(
                    forName: UIDevice.orientationDidChangeNotification,
                    object: nil,
                    queue: .main
                ) { _ in
                    print("qwerqwer addObserver -> \(UIDevice.current.orientation)")
                    if let connection = cameraLayer.connection {
                        switch UIDevice.current.orientation {
                        case .portrait:
                            connection.videoOrientation = .portrait
                        case .portraitUpsideDown:
                            connection.videoOrientation = .portraitUpsideDown
                        case .landscapeLeft:
                            connection.videoOrientation = .landscapeRight
                        case .landscapeRight:
                            connection.videoOrientation = .landscapeLeft
                        default:
                            connection.videoOrientation = .portrait
                        }
                    }
                }
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

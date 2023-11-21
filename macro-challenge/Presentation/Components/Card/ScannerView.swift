//
//  ScannerView.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 26/10/23.
//

import SwiftUI
import AVKit
//View For Testing Only
struct ScannerView: View {
    @State private var isFlipped = false
    @ObservedObject private var viewModel: ScannerViewModel = ScannerViewModel()
    
    @State private var scannedData: String = ""
    @State private var cameraPermission: Permission = .idle
    
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        VStack(spacing: 8) {
            
            Text("Kartu -> \(viewModel.scannedData)")
                .font(.callout)
                .foregroundColor(.gray)
            VStack {
                if isFlipped {
                    BackCardView(cardVowelStyle: CardVowelStyleEnum.A_VOWEL)
                } else {
                    FrontCardView(syllable: "bu", cardVowelStyle: CardVowelStyleEnum.A_VOWEL)
                }
            }
            .onTapGesture {
                withAnimation {
                    isFlipped.toggle()
                }
            }
            .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
            .animation(.default, value: isFlipped)
            .padding()
            
            Spacer(minLength: 0)
            
            QRCameraView(cameraSession: viewModel.qrScannerManager.captureSession, frameSize: CGSize(width: 600, height: 250))
            Button {
                checkCameraPermission()
            } label: {
                Text("Start")
            }
            
            Button {
                viewModel.stopScanning()
            } label: {
                Text("STop")
            }
            
            Spacer(minLength: 15)
            
            
        }
        .onAppear {
            checkCameraPermission()
        }
        .padding(15)
        
        
    }
    
    func checkCameraPermission() {
        Task {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                print("Approved")
                cameraPermission = .approved
                viewModel.startScanning()
                
            case .notDetermined:
                if await AVCaptureDevice.requestAccess(for: .video) {
                    print("Approved")
                    cameraPermission = .approved
                    viewModel.startScanning()
                } else {
                    print("denied")
                    cameraPermission = .denied
                    presentError("Please Provide Access to Camera for Scanning Codes")
                }
            case .denied, .restricted:
                print("denied")
                cameraPermission = .denied
                presentError("Please Provide Access to Camera for Scanning Codes")
            default: break
            }
        }
    }
    
    func presentError(_ message: String) {
        errorMessage = message
        showError.toggle()
    }
}

//struct ScannerView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        var viewModel: ScannerViewModel = ScannerViewModel()
//        var cameraSession: AVCaptureSession
//        ScannerView()
//    }
//}

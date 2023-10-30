//
//  ScanWordActivity.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 30/10/23.
//

import SwiftUI
import AVKit

struct ScanWordActivity: View {
    @ObservedObject var viewModel : FlowScreenViewModel
    @State var width : CGFloat = 500
    @State var height : CGFloat = 200
    @State var crack : Bool = true
    @State var screenWidth = CGFloat(UIScreen.main.bounds.width)
    @State var screenHeight = CGFloat(UIScreen.main.bounds.height)
    @State private var cameraPermission: Permission = .idle
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    
    
    var body: some View {
        VStack {
            SyllableLabel(syllable: (viewModel.word?.syllables[0].content)!, height: height, width: width/2, show: $crack)
            
            HStack {
                Spacer()
                QrCameraView(cameraSession: viewModel.qrScannerManager.captureSession , frameSize: CGSize(width: 600, height: 250))
                Spacer()
            }
        }.position(CGPoint(x: screenWidth/2, y: screenHeight/2))
            .onAppear {
            viewModel.playInstruction()
            viewModel.setupQrScannerManager()
            checkCameraPermission()
            }.onAppear() {
                viewModel.getInstruction()
                viewModel.playInstruction()
            }
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

struct BreakWord_Previews: PreviewProvider {
    static var previews: some View {
        ScanWordActivity(viewModel: FlowScreenViewModel())
    }
}

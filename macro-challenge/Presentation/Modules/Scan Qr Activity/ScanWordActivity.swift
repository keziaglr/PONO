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
    @State private var scale : [Bool] = [false, false]
    
    
    var body: some View {
        ZStack(alignment:.topLeading) {
            QrCameraView(cameraSession: viewModel.qrScannerManager.captureSession , frameSize: CGSize(width: 900, height:450))
            VStack {
                MergedSyllable(syllables: viewModel.word?.syllables, syllableType: viewModel.type)
            }.padding(.top, 20)
        }.frame(width: 900, height: 450).onAppear {
            viewModel.getInstruction()
            viewModel.playInstruction()
            checkCameraPermission()
        }.background(Color.red)
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

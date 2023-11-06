//
//  RecordWordActivity.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 30/10/23.
//

import SwiftUI

struct RecordActivity: View, ActivityViewProtocol {
    var next: () -> Void
    
    @State var record = false
    @ObservedObject var vm : FlowScreenViewModel
    @State var isRecording = false
    @State var recordingStatus: RecordingStatus = .idle


    var body: some View {
        VStack{
            Spacer()
            PronounceInstruction(vm: vm, isRecording: $isRecording)
            Spacer()
            RecordingAudio(record: $record, recordingStatus: $recordingStatus)
                .onAppear {
                    isRecording = true
                    Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
                        self.record = true
                        self.recordingStatus = .recording
                        RecordingManager.shared.startRecord(for: 4.0) { audioRecord in
                            self.record = false
                            self.recordingStatus = .idle

                            next()
                        }
                    }
                }
            
        }.onAppear{
            vm.playInstruction()
        }.padding()
    }
}

struct RecordActivity_Previews: PreviewProvider {
    static var previews: some View {
        RecordActivity(next: {}, vm : FlowScreenViewModel(), isRecording: false)
    }
}

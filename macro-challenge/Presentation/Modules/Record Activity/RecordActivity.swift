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
    var body: some View {
        VStack{
            Spacer()
            PronounceInstruction(vm: vm)
            Spacer()
            RecordingAudio(record: $record)
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
                        self.record = true
                        RecordingManager.shared.startRecord(for: 4.0) { audioRecord in
                            self.record = false
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
        RecordActivity(next: {}, vm : FlowScreenViewModel())
    }
}

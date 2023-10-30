//
//  PlayRecordActivity.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 30/10/23.
//

import SwiftUI

struct PlayRecordActivity: View {
    @ObservedObject var vm : FlowScreenViewModel
    @State var drawingHeight = true
    var body: some View {
        HStack{
            PlayRecord(drawingHeight: $drawingHeight)
                .onTapGesture {
                    drawingHeight.toggle()
                    RecordingManager.shared.playRecording(RecordingManager.shared.record!)
                }
            PronounceInstruction(vm: vm)
                .padding()
        }.onAppear{
            vm.playInstruction()
        }
    }
}

struct PlayRecordActivity_Previews: PreviewProvider {
    static var previews: some View {
        PlayRecordActivity(vm : FlowScreenViewModel())
    }
}

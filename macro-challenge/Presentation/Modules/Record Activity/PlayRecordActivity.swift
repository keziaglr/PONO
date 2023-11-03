//
//  PlayRecordActivity.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 30/10/23.
//

import SwiftUI

struct PlayRecordActivity: View, ActivityViewProtocol {
    var next: () -> Void
    
    @ObservedObject var vm : FlowScreenViewModel
    @State var drawingHeight = true
    @State var showBtn = false
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                if showBtn{
                    HStack {
                        Button {
                            next()
                        } label: {
                            Image(systemName: "arrow.right")
                        }
                        .buttonStyle(PonoButtonStyle(variant: .primary))
                        Button{
                            vm.tryAgain()
                        }label: {
                            Image(systemName: "arrow.counterclockwise")
                        }.buttonStyle(PonoButtonStyle(variant: .secondary))
                        
                    }.padding(20)
                }
            }
            HStack{
                PronounceInstruction(vm: vm)
                PlayRecord(action: {
                    drawingHeight.toggle()
                    RecordingManager.shared.playRecording(RecordingManager.shared.record!)
                    showBtn = true
                }, drawingHeight: $drawingHeight)
            }.onAppear{
                vm.playInstruction()
        }
        }
    }
}

struct PlayRecordActivity_Previews: PreviewProvider {
    static var previews: some View {
        PlayRecordActivity(next: {}, vm : FlowScreenViewModel())
    }
}

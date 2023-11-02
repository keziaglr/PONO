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
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Button {
                        next()
                    } label: {
                        Image(systemName: "arrow.right")
                            .font(Font.system(size: 50, weight: .bold))
                            .foregroundStyle(Color.White1)
                            .padding()
                    }
                    .buttonStyle(PonoButtonStyle(variant: .primary))
                    Button{
                        vm.tryAgain()
                    }label: {
                        Image(systemName: "arrow.counterclockwise")
                            .font(Font.system(size: 40, weight: .bold))
                            .foregroundStyle(Color.Blue1)
                            .padding()
                    }.buttonStyle(PonoButtonStyle(variant: .secondary))
                    
                }.padding(20)
            }
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
}

struct PlayRecordActivity_Previews: PreviewProvider {
    static var previews: some View {
        PlayRecordActivity(next: {}, vm : FlowScreenViewModel())
    }
}

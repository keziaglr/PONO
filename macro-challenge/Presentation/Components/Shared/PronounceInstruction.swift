//
//  PronounceInstruction.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 29/10/23.
//

import SwiftUI

struct PronounceInstruction: View {
    @ObservedObject var vm : FlowScreenViewModel
    @State var isPressed = false
    
    @Binding var isRecording : Bool
    
    
    var body: some View {
        
        HStack {
//            Image(systemName: "speaker.wave.2.fill")
//                .resizable()
//                .frame(width: 29, height: 22)
//                .foregroundStyle(Color.Blue2)
//                .padding()

            Button {
                switch vm.type {
                case .syllable1:
                    vm.soundSyllable(sound: [(vm.word?.syllable(at: 0))!])
                case .syllable2:
                    vm.soundSyllable(sound: [(vm.word?.syllable(at: 1))!])
                case .word:
                    vm.soundSyllable(sound: [(vm.word?.syllable(at: 0))!, (vm.word?.syllable(at: 1))!])
                }
            } label: {
                if vm.type == .word {
                    Text("\((vm.word?.syllable(at: 0))!) - \((vm.word?.syllable(at: 1))!)")
                        .foregroundColor(Color.Grey1)
                        .font(
                            .custom(FontConst.QUICKSAND_BOLD, size: 50)
                        ).padding()
                } else if vm.type == .syllable1{
                    Text("\((vm.word?.syllable(at: 0))!)")
                        .foregroundColor(Color.Grey1)
                        .font(
                            .custom(FontConst.QUICKSAND_BOLD, size: 50)
                        ).padding()
                } else if vm.type == .syllable2{
                    Text("\((vm.word?.syllable(at: 1))!)")
                        .foregroundColor(Color.Grey1)
                        .font(
                            .custom(FontConst.QUICKSAND_BOLD, size: 50)
                        ).padding()
                }
            }.buttonStyle(PonoButtonStyle(variant: .secondary))
                .disabled(isRecording)
            
        }
//        .onTapGesture {
//            isPressed = true
//
//        }
//        .padding(.horizontal, 20)
//        .frame(width: 200, height: 200)
//        .background(
//            RoundedRectangle(cornerRadius: 16)
//                .fill(Color.white)
//                .shadow(color: isPressed ? .clear : Color.Grey2, radius: 0, x: 0, y: 8)
//        )
//        .offset(y: isPressed ? 0 : 8)
    }
}

struct PronounceInstruction_Previews: PreviewProvider {
    static var previews: some View {
        PronounceInstruction(vm: FlowScreenViewModel(), isRecording: .constant(true))
    }
}

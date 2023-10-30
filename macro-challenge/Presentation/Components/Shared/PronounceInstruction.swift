//
//  PronounceInstruction.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 29/10/23.
//

import SwiftUI

struct PronounceInstruction: View {
//    @State var type : TypeReading
    @ObservedObject var vm : FlowScreenViewModel
    var body: some View {
        
        HStack {
            Image(systemName: "speaker.wave.2.fill")
                .resizable()
                .frame(width: 29, height: 22)
                .foregroundStyle(Color.Blue2)
                .padding()
                .onTapGesture {
                    switch vm.type {
                    case .syllable1:
                        vm.soundSyllable(sound: [(vm.word?.syllable(at: 0))!])
                    case .syllable2:
                        vm.soundSyllable(sound: [(vm.word?.syllable(at: 1))!])
                    case .word:
                        vm.soundSyllable(sound: [(vm.word?.syllable(at: 0))!, (vm.word?.syllable(at: 1))!])
                    }
                }
            
            if vm.type == .word {
                Text("\((vm.word?.syllable(at: 0))!) - \((vm.word?.syllable(at: 1))!)")
                    .foregroundColor(Color.Grey1)
                    .font(
                        .custom(FontConst.QUICKSAND_BOLD, size: 40)
                    ).padding()
            } else if vm.type == .syllable1{
                Text("\((vm.word?.syllable(at: 0))!)")
                    .foregroundColor(Color.Grey1)
                    .font(
                        .custom(FontConst.QUICKSAND_BOLD, size: 40)
                    ).padding()
            } else if vm.type == .syllable2{
                Text("\((vm.word?.syllable(at: 1))!)")
                    .foregroundColor(Color.Grey1)
                    .font(
                        .custom(FontConst.QUICKSAND_BOLD, size: 40)
                    ).padding()
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 100)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.Grey2, radius: 2, y: 2)
        )
    }
}

struct PronounceInstruction_Previews: PreviewProvider {
    static var previews: some View {
        PronounceInstruction(vm: FlowScreenViewModel())
    }
}

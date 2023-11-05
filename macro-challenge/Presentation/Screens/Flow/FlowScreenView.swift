//
//  FlowScreenView.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 24/10/23.
//

import SwiftUI

struct FlowScreenView: View {
    @ObservedObject var vm = FlowScreenViewModel()
    @State var screenWidth = CGFloat(UIScreen.main.bounds.width)
    @State var screenHeight = CGFloat(UIScreen.main.bounds.height)
    var body: some View {
        ZStack{
            Image("cloud")
                .resizable()
                .scaledToFit()
            VStack{
                ProgressBarView(width: screenWidth/1.1, height: screenHeight/25, percent: $vm.percent)
                    .padding()
                InstructionView(height: screenHeight/12, message: $vm.instruction)
                    .padding()
                    .opacity(vm.instruction.isEmpty ? 0 : 1)
                    .onTapGesture {
                        vm.playInstruction()
                    }
                Spacer()
                
            }
            if vm.activity == .beforeBreakWord || vm.activity == .afterBreakWord{
                BreakWordActivity(next: {
                    vm.nextStep()
                }, vm: vm)
            } else if vm.activity == .beforeBlendWord || vm.activity == .afterBlendWord{
                BlendWordActivity(next:{
                    vm.nextStep()
                }, vm : vm)
            } else if vm.activity == .beforeCard1 || vm.activity == .beforeCard2 {
                ScanWordActivity(viewModel: vm).padding(.top,200)
            } else if vm.activity == .afterCard {
                PreviewCardActivity(next: {
                    vm.nextStep()
                    vm.isCardFlipped.toggle()
                }, viewModel: vm, isCardChecked: false, syllable: vm.scannedCard?.content ?? "ba",cardVowelStyle: vm.scannedCard?.content.getCardVowelStyle() ?? CardVowelStyleEnum.A_VOWEL)
            } else if vm.activity == .correctCard {
                PreviewCardActivity(next: {
                    vm.nextStep()
                }, viewModel: vm, isCardChecked: true, syllable: vm.scannedCard?.content ?? "ba",cardVowelStyle: vm.scannedCard?.content.getCardVowelStyle() ?? CardVowelStyleEnum.A_VOWEL)
            } else if vm.activity == .wrongCard {
                PreviewCardActivity(next: {
                    vm.nextStep()
                }, viewModel: vm, isCardChecked: true, syllable: vm.scannedCard?.content ?? "ba",cardVowelStyle: vm.scannedCard?.content.getCardVowelStyle() ?? CardVowelStyleEnum.A_VOWEL)
            } else if vm.activity == .beforeReadSyllable1 || vm.activity == .beforeReadSyllable2 {
                RecordActivity(next: {
                    vm.nextStep()
                }, vm: vm, isRecording: false)
            } else if vm.activity == .beforeReadWord {
                RecordActivity(next: {
                    vm.nextStep()
                }, vm: vm, isRecording: false)
            }else if vm.activity == .afterReadSyllable || vm.activity == .afterReadWord{
                PlayRecordActivity(next: {
                    vm.nextStep()
                }, vm: vm)
            }
        }.background(Color.Blue3)
    }
}

struct FlowScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FlowScreenView()
    }
}

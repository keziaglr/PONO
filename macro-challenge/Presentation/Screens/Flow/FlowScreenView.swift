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
//                if vm.activity == .wrongCard || vm.activity == .afterReadSyllable || vm.activity == .afterReadWord{
//                    HStack {
//                        ButtonView(height: screenHeight/18, image: "\(ImageConst.IC_RELOAD_WHITE)")
//                            .onTapGesture {
//                                vm.tryAgain()
//                            }
//                            .padding()
//                        NextButton()
//                            .onTapGesture {
//                                vm.nextStep()
//                            }
//                    }.padding(.horizontal, 20)
//
//                } else {
//                    ButtonView(height: screenHeight/18, image: "\(ImageConst.IC_ARROW_NEXT_WHITE)")
//                        .opacity(vm.activity == .beforeBreakWord || vm.activity == .beforeBlendWord || vm.activity == .beforeCard1 || vm.activity == .beforeCard2 || vm.activity == .beforeReadSyllable2 || vm.activity == .beforeReadSyllable1 || vm.activity == .beforeReadWord ? 0 : 1)
//                        .onTapGesture {
//                            if vm.activity == .afterCard {
//                                vm.nextStep()
//                                vm.isCardFlipped.toggle()
//                            } else {
//                                vm.nextStep()
//                            }
//                        }.padding(.horizontal, 20)
//                }
                
            }
            if vm.activity == .beforeBreakWord || vm.activity == .afterBreakWord{
                BreakWordActivity(next: {
                    vm.setActivity(act: .beforeCard1)
                }, vm: vm)
            } else if vm.activity == .beforeBlendWord || vm.activity == .afterBlendWord{
                BlendWordActivity(next:{ vm.setActivity(act: .beforeReadWord)}, vm : vm)
            } else if vm.activity == .beforeCard1 || vm.activity == .beforeCard2 {
                ScanWordActivity(viewModel: vm).padding(.top,200)
            } else if vm.activity == .afterCard {
                PreviewCardActivity(next: {
                    vm.isScannedCardCorrect()
                }, viewModel: vm, isCardChecked: false, syllable: vm.scannedCard?.content ?? "bu",cardVowelStyle: vm.scannedCard?.content.getCardVowelStyle() ?? CardVowelStyleEnum.A_VOWEL)
            } else if vm.activity == .correctCard {
                PreviewCardActivity(next: {
                    if vm.type == .syllable1{
                        vm.setActivity(act: .beforeReadSyllable1)
                    }else {
                        vm.setActivity(act: .beforeReadSyllable2)
                    }
                }, viewModel: vm, isCardChecked: true, syllable: vm.scannedCard?.content ?? "ba",cardVowelStyle: vm.scannedCard?.content.getCardVowelStyle() ?? CardVowelStyleEnum.A_VOWEL)
            } else if vm.activity == .wrongCard {
                PreviewCardActivity(next: {
                    if vm.type == .syllable1{
                        vm.setActivity(act: .beforeReadSyllable1)
                    }else {
                        vm.setActivity(act: .beforeReadSyllable2)
                    }
                }, viewModel: vm, isCardChecked: true, syllable: vm.scannedCard?.content ?? "A",cardVowelStyle: vm.scannedCard?.content.getCardVowelStyle() ?? CardVowelStyleEnum.A_VOWEL)
            } else if vm.activity == .beforeReadSyllable1 || vm.activity == .beforeReadSyllable2 {
                RecordActivity(next: {vm.setActivity(act: .afterReadSyllable)}, vm: vm)
            } else if vm.activity == .beforeReadWord {
                RecordActivity(next: {vm.setActivity(act: .afterReadWord)}, vm: vm)
            }else if vm.activity == .afterReadSyllable || vm.activity == .afterReadWord{
                PlayRecordActivity(vm: vm)
            }
        }.background(Color.Blue3)
    }
}

struct FlowScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FlowScreenView()
    }
}

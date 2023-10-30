//
//  FlowScreenView.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 24/10/23.
//

import SwiftUI

struct FlowScreenView: View {
    @StateObject var vm = FlowScreenViewModel()
    @State var screenWidth = CGFloat(UIScreen.main.bounds.width)
    @State var screenHeight = CGFloat(UIScreen.main.bounds.height)
    var body: some View {
        ZStack{
            VStack{
                ProgressBarView(width: screenWidth/1.1, height: screenHeight/25, percent: $vm.percent)
                    .padding()
                InstructionView(height: screenHeight/12, message: $vm.instruction)
                    .padding()
                    .onTapGesture {
                        vm.playInstruction()
                    }
                Spacer()
                if vm.activity == .wrongCard {
                    HStack {
                        ButtonView(height: screenHeight/18, image: "\(ImageConst.IC_RELOAD_WHITE)")
                            .opacity(vm.activity == .beforeBreakWord || vm.activity == .beforeBlendWord || vm.activity == .beforeCard1 ? 0 : 1)
                            .onTapGesture {
                                vm.setActivity(act: .beforeCard1)
                            }
                        Image("ic_arrow_next_blue").onTapGesture {
                            vm.nextStep()
                        }
                    }.padding(.horizontal, 20)
                    
                } else {
                    ButtonView(height: screenHeight/18, image: "\(ImageConst.IC_ARROW_NEXT_WHITE)")
                        .opacity(vm.activity == .beforeBreakWord || vm.activity == .beforeBlendWord || vm.activity == .beforeCard1 ? 0 : 1)
                        .onTapGesture {
                            print("ACTIVITY \(vm.activity)")
                            if vm.activity == .afterCard {
                                vm.nextStep()
                                vm.isCardFlipped.toggle()
                            } else {
                                vm.nextStep()
                            }
                        }.padding(.horizontal, 20)
                }
                
            }
            if vm.activity == .beforeBreakWord || vm.activity == .afterBreakWord{
                BreakWordActivity(vm: vm)
            } else if vm.activity == .beforeBlendWord || vm.activity == .afterBlendWord{
                BlendWordActivity(vm : vm)
            } else if vm.activity == .beforeCard1 {
                ScanWordActivity(viewModel: vm)
            } else if vm.activity == .afterCard {
                PreviewCardActivity(viewModel: vm, isCardChecked: false, syllable: vm.scannedCard?.content ?? "A",cardVowelStyle: vm.scannedCard?.content.getCardVowelStyle() ?? CardVowelStyleEnum.A_VOWEL)
            } else if vm.activity == .correctCard {
                PreviewCardActivity(viewModel: vm, isCardChecked: true, syllable: vm.scannedCard?.content ?? "A",cardVowelStyle: vm.scannedCard?.content.getCardVowelStyle() ?? CardVowelStyleEnum.A_VOWEL)
            } else if vm.activity == .wrongCard {
                PreviewCardActivity(viewModel: vm, isCardChecked: true, syllable: vm.scannedCard?.content ?? "A",cardVowelStyle: vm.scannedCard?.content.getCardVowelStyle() ?? CardVowelStyleEnum.A_VOWEL)
            }
        }
    }
}

struct FlowScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FlowScreenView()
    }
}

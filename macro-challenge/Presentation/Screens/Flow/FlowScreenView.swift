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
                ButtonView(height: screenHeight/18, image: "arrow.right")
                    .opacity(vm.activity == .beforeBreakWord || vm.activity == .beforeBlendWord ? 0 : 1)
                    .onTapGesture {
                        vm.nextStep()
                    }
            }
            if vm.activity == .beforeBreakWord || vm.activity == .afterBreakWord{
                BreakWordActivity(vm: vm)
            }else if vm.activity == .beforeBlendWord || vm.activity == .afterBlendWord{
                BlendWordActivity(vm : vm)
            }
        }
    }
}

struct FlowScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FlowScreenView()
    }
}

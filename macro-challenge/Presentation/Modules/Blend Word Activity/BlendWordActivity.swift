//
//  BlendWordActivity.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 25/10/23.
//

import SwiftUI

struct BlendWordActivity: View, ActivityViewProtocol {
    var next: () -> Void
    
    @State var width : CGFloat = 500
    @State var height : CGFloat = 200
    @State var screenWidth = CGFloat(UIScreen.main.bounds.width)
    @State var screenHeight = CGFloat(UIScreen.main.bounds.height)
    @State var show : Bool = true
    @ObservedObject var vm : FlowScreenViewModel
    @State private var dragOffset : [CGFloat] = [0.0, 0.0]
    @GestureState private var translation: CGSize = .zero
    @GestureState private var translation2: CGSize = .zero
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack{
                    Spacer()
                    if vm.activity == .afterBlendWord {
                        Button {
                            next()
                        } label: {
                            Image(systemName: "arrow.right")
                                .font(Font.system(size: 50, weight: .bold))
                                .foregroundStyle(Color.White1)
                                .padding()
                                .zIndex(1)
                        }
                        .buttonStyle(PonoButtonStyle(variant: .primary))
                    .padding(20)
                    } 
                    
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.Blue3)
                        .frame(width: width + width/10, height: height)
                        .position(CGPoint(x: screenWidth/2, y: screenHeight/2))
                        .opacity(show ? 0 : 1)
                        .animation(.easeInOut, value: show)
                        .onChange(of: [translation, translation2]) { newValue in
                            if dragOffset[1] < -width/4.5 && dragOffset[0] > width/4.5{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    show = false
                                    next()
                                }
                            }
                        }
                    
                    HStack(spacing: height) {
                        SyllableLabel(left: true, scale: .constant(false), syllable: (vm.word?.syllables[0].content)!, height: height, width: width/2, show: $show)
                            .offset(x: min(max(dragOffset[0] + translation.width, 0), width / 4.5))
                            .animation(.easeInOut, value: translation)
                            .gesture(
                                DragGesture()
                                    .updating($translation) { value, state, _ in
                                        state = value.translation
                                    }
                                    .onEnded { value in
                                        if show{
                                            dragOffset[0] += value.translation.width
                                        }
                                    }
                            )
                        SyllableLabel(left: false, scale: .constant(false), syllable: (vm.word?.syllables[1].content)!, height: height, width: width/2, show: $show)
                            .offset(x: min(max(dragOffset[1] + translation2.width, -width/4.5), 0))
                            .animation(.easeInOut, value: translation2)
                            .gesture(
                                DragGesture()
                                    .updating($translation2) { value, state, _ in
                                        state = value.translation
                                    }
                                    .onEnded { value in
                                        if show{
                                            dragOffset[1] += value.translation.width
                                        }
                                    }
                            )
                    }
                    .position(CGPoint(x: screenWidth/2, y: screenHeight/2))
                    
                    
                }.onAppear{
                    vm.playInstruction()
                }.onChange(of: show) { newValue in
                    vm.playInstruction()
            }
            }
        }
    }
}

struct BlendWordActivity_Previews: PreviewProvider {
    static var previews: some View {
        BlendWordActivity(next: {}, vm : FlowScreenViewModel())
    }
}

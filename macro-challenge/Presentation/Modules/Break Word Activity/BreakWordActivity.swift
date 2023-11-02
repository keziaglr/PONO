//
//  BreakWord.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 23/10/23.
//

import SwiftUI

struct BreakWordActivity: View, ActivityViewProtocol{
    var next: () -> Void
    
    @State var width : CGFloat = 500
    @State var height : CGFloat = 200
    @State var screenWidth = CGFloat(UIScreen.main.bounds.width)
    @State var screenHeight = CGFloat(UIScreen.main.bounds.height)
    @State var crack : Bool = false
    @ObservedObject var vm : FlowScreenViewModel
    @State private var dragOffset : [CGFloat] = [0.0, 0.0]
    @State private var isOffsetUp = true
    @State private var firstTap = false
    @State private var scale : [Bool] = [false, false]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack{
                    Spacer()
                    if vm.activity == .afterBreakWord {
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
                        .padding(.horizontal, 20)
                    }
                    
                }
                
                ZStack {
                    SyllableLabel(left: true, scale: $scale[0], syllable: (vm.word?.syllables[0].content)!, height: height, width: width/2, show: $crack)
                        .offset(x: dragOffset[0])
                        .position(CGPoint(x: screenWidth/2.53, y: screenHeight/2))
                        .animation(.easeOut(duration: 1), value: dragOffset)
                        .onChange(of: crack) { newValue in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                dragOffset[0] = dragOffset[0] - 100.0
                            }
                        }
                    
                    SyllableLabel(left: false, scale: $scale[1], syllable: (vm.word?.syllables[1].content)!, height: height, width: width/2, show: $crack)
                        .offset(x: dragOffset[1])
                        .animation(.easeOut(duration: 1), value: dragOffset)
                        .position(CGPoint(x: screenWidth/1.66, y: screenHeight/2))
                        .onChange(of: crack) { newValue in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                dragOffset[1] = dragOffset[1] + 100.0
                            }
                        }
                    
                    
                    if !crack {
                        ZStack {
                            Path { path in
                                insertDottedPath(start: CGPoint(x: screenWidth/2, y: screenHeight/2-height/3.5), end : CGPoint(x: screenWidth/2, y: screenHeight/2+height/3), path: &path)
                            }.stroke(Color.Blue1, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round, dash: [10]))
                                .gesture(
                                    DragGesture(minimumDistance: height/2)
                                        .onChanged({ (value) in
                                            crack = true
                                            if vm.activity == .beforeBreakWord{
                                                vm.setActivity(act: .afterBreakWord)
                                            }
                                        })
                                )
                            if !firstTap {
                                ZStack {
                                    Image(systemName: "hand.point.up.left.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40)
                                        .foregroundColor(Color.White1)
                                        .overlay(
                                            Image(systemName: "hand.point.up.left")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 40)
                                                .foregroundColor(Color.Grey2)
                                        )
                                }.position(CGPoint(x: screenWidth/2+width/30, y: screenHeight/2-height/5))
                                    .offset(y: isOffsetUp ? 0 : 120)
                                    .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(0.3), value: isOffsetUp)
                                    .onAppear{
                                        isOffsetUp.toggle()
                                    }
                            }
                            
                        }
                        
                    }
                }.simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            firstTap = true
                        }
                )
                .onAppear{
                    vm.playInstruction()
                }.onChange(of: crack) { newValue in
                    vm.playInstruction()
                }
                .onChange(of: vm.index) { newValue in
                    scale[0] = false
                    scale[1] = false
                    
                    if vm.index == 1 {
                        scale[0] = true
                    } else if vm.index == 2 {
                        scale[1] = true
                    } else if vm.activity == .afterBreakWord {
                        if vm.index == 4 {
                            scale[0] = true
                        } else if vm.index == 6 {
                            scale[1] = true
                        }
                    }
            }
            }
        }
    }
    
    func insertDottedPath(start: CGPoint, end: CGPoint, path: inout Path){
        path.move(to: start)
        path.addLine(to: end)
    }
    
}

struct BreakWordActivity_Previews: PreviewProvider {
    static var previews: some View {
        BreakWordActivity(next: {}, vm: FlowScreenViewModel())
    }
}

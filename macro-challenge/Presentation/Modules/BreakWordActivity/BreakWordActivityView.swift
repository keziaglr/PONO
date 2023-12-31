//
//  BreakWordActivityView.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 15/11/23.
//

import SwiftUI

struct BreakWordActivityView: View {
    
    @ObservedObject private var viewModel: BreakWordActivityViewModel
    
    private let onNext: () -> Void
    
    // UI-Related properties
    @State private var width : CGFloat = 600
    @State private var height : CGFloat = 300
    @State private var isWordBroke : Bool = false
    @State private var dragOffset : [CGFloat] = [0.0, 0.0]
    @State private var isOffsetUp = true
    @State private var firstTap = false
    @State private var scale : [Bool] = [false, false]
    @State private var instructionText : String = ""
    private let screenWidth = CGFloat(UIScreen.main.bounds.width)
    private let screenHeight = CGFloat(UIScreen.main.bounds.height)
    @State private var buttonTapped = false
    
    init(learningWord: Word, onNext: @escaping () -> Void) {
        self.viewModel = BreakWordActivityViewModel(learningWord: learningWord)
        self.onNext = onNext
    }
    
    var body: some View {
            ZStack {
                VStack {
                    InstructionView(height: screenHeight / 12,
                                    message: $instructionText)
                    .padding(.top, 100)
                    .opacity(viewModel.currentInstruction == nil ? 0 : 1)
                    .onAppear {
                        instructionText = viewModel.currentInstruction?.text ?? ""
                    }
                    .onChange(of: viewModel.currentInstruction, perform: { _ in
                        instructionText = viewModel.currentInstruction?.text ?? ""
                    })
                    .onTapGesture {
                        viewModel.playInstruction(isReplay: true)
                    }
                    
                    Spacer()
                }
                
                VStack{
                    Spacer()
                    
                    if viewModel.currentInstructionVoiceIndex == 6 {
                        Button {
                            buttonTapped.toggle()
                            onNext()
                        } label: {
                            Image(systemName: "arrow.right")
                        }
                        .buttonStyle(PonoButtonStyle(variant: .primary))
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)
                        .disabled(buttonTapped)
                    }
                }
                
                ZStack {
                    HStack(spacing: -10) {
                        SyllableLabelView(left: true,
                                      scale: $scale[0],
                                      syllable: viewModel.learningWord.syllable(at: 0),
                                      height: height,
                                      width: width / 2,
                                      show: $isWordBroke)
                        .offset(x: dragOffset[0])
                        .animation(.easeOut(duration: 1), value: dragOffset)
                        .onChange(of: isWordBroke) { newValue in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                dragOffset[0] = dragOffset[0] - 100.0
                            }
                        }
                        
                        SyllableLabelView(left: false,
                                      scale: $scale[1],
                                      syllable: viewModel.learningWord.syllable(at: 1),
                                      height: height,
                                      width: width / 2,
                                      show: $isWordBroke)
                        .offset(x: dragOffset[1])
                        .animation(.easeOut(duration: 1), value: dragOffset)
                        .onChange(of: isWordBroke) { newValue in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                dragOffset[1] = dragOffset[1] + 100.0
                            }
                        }
                    }
                    .position(x: screenWidth / 2, y: screenHeight / 2)
                    
                    if !isWordBroke {
                        ZStack {
                            Path { path in
                                insertDottedPath(start: CGPoint(x: screenWidth/2, y: screenHeight/2-height/4.5), end : CGPoint(x: screenWidth/2, y: screenHeight/2+height/4), path: &path)
                            }
                            .stroke(Color.Blue1, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round, dash: [10]))
                            
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
                                }
                                .position(CGPoint(x: screenWidth / 2 + width / 30, y: screenHeight / 2 - height / 5))
                                .offset(y: isOffsetUp ? 0 : 120)
                                .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(0.3), value: isOffsetUp)
                                .onAppear{
                                    isOffsetUp.toggle()
                                }
                            }
                            
                        }
                        
                    }
                }
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            firstTap = true
                        }
                )
                .simultaneousGesture(
                    DragGesture(minimumDistance: height/2)
                        .onChanged({ (value) in
                            ContentManager.shared.playAudio("break-word", type: "wav")
                            isWordBroke = true
                        })
                )
                .onAppear{
                    viewModel.playInstruction()
                }.onChange(of: isWordBroke) { newValue in
                    viewModel.playInstruction()
                }
                .onChange(of: viewModel.currentInstructionVoiceIndex) { newValue in
                    scale[0] = false
                    scale[1] = false
                    
                    if isWordBroke {
                        if newValue == 4 || newValue == 1 {
                            scale[0] = true
                        } else if newValue == 6 || newValue == 2{
                            scale[1] = true
                        }
                    } else {
                        if newValue == 1 {
                            scale[0] = true
                        } else if newValue == 2 {
                            scale[1] = true
                        }
                    }
                }
            }
    }
}

extension BreakWordActivityView {
    private func insertDottedPath(start: CGPoint, end: CGPoint, path: inout Path){
        path.move(to: start)
        path.addLine(to: end)
    }
    
}

//#Preview {
//    BreakWordActivityView(learningWord: PreviewDataResources.word, onNext: { })
//}

//
//  CombineSyllableActivityView.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 15/11/23.
//

import SwiftUI

struct CombineSyllableActivityView: View {
    
    @ObservedObject private var viewModel: CombineSyllableActivityViewModel
    
    private let onNext: () -> Void
    
    // UI-related properties
    @State private var width: CGFloat = 600
    @State private var height: CGFloat = 200
    @State private var screenWidth = CGFloat(UIScreen.main.bounds.width)
    @State private var screenHeight = CGFloat(UIScreen.main.bounds.height)
    @State private var show: Bool = true
    @State private var isSyllableCombined: Bool = false
    @State private var dragOffset: [CGFloat] = [0.0, 0.0]
    @GestureState private var translation: CGSize = .zero
    @GestureState private var translation2: CGSize = .zero
    @State private var instructionText = ""
    @State private var buttonTapped = false
    
    init(learningWord: Word, onNext: @escaping () -> Void) {
        self.viewModel = CombineSyllableActivityViewModel(learningWord: learningWord)
        self.onNext = onNext
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    InstructionView(height: screenHeight / 12,
                                    message: $instructionText)
                    .padding(.top, 100)
                    .onAppear {
                        instructionText = viewModel.currentInstruction?.text ?? ""
                    }
                    .onChange(of: viewModel.currentInstruction, perform: { _ in
                        instructionText = viewModel.currentInstruction?.text ?? ""
                    })
                    .padding()
                    .opacity(viewModel.currentInstruction == nil ? 0 : 1)
                    .onTapGesture {
                        viewModel.playInstruction(isReplay: true)
                    }
                    
                    Spacer()
                }
                
                VStack{
                    Spacer()
                    
                    if isSyllableCombined {
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
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.Blue3)
                        .frame(width: width + width/10, height: height)
                        .position(CGPoint(x: screenWidth/2, y: screenHeight/2))
                        .opacity(show ? 0 : 1)
                        .animation(.easeInOut, value: show)
                        .onChange(of: [translation, translation2]) { newValue in
                            if dragOffset[1] < -height/2 && dragOffset[0] > height/2 {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    show = false
                                    isSyllableCombined = true
                                }
                            }
                            
                            if dragOffset[1] < -height/2 {
                                ContentManager.shared.playAudio("blend-word-2", type: "wav")
                            }
                            
                            if dragOffset[0] > height/2 {
                                ContentManager.shared.playAudio("blend-word", type: "wav")
                            }
                        }
                    
                    HStack(spacing: height) {
                        SyllableLabelView(left: true,
                                      scale: .constant(false),
                                      syllable: viewModel.learningWord.syllable(at: 0),
                                      height: height,
                                      width: width/2,
                                      show: $show)
                        .offset(x: min(max(dragOffset[0] + translation.width, 0), height/2))
                        .animation(.easeInOut, value: translation)
                        .gesture(
                            DragGesture()
                                .updating($translation) { value, state, _ in
                                    state = value.translation
                                }
                                .onEnded { value in
                                    if show {
                                        dragOffset[0] += value.translation.width
                                        ContentManager.shared.playAudio("break-word", type: "wav")
                                    }
                                }
                        )
                        
                        SyllableLabelView(left: false,
                                      scale: .constant(false),
                                      syllable: viewModel.learningWord.syllable(at: 1),
                                      height: height,
                                      width: width/2,
                                      show: $show)
                        .offset(x: min(max(dragOffset[1] + translation2.width, -height / 2), 0))
                        .animation(.easeInOut, value: translation2)
                        .gesture(
                            DragGesture()
                                .updating($translation2) { value, state, _ in
                                    state = value.translation
                                }
                                .onEnded { value in
                                    if show {
                                        dragOffset[1] += value.translation.width
                                        ContentManager.shared.playAudio("break-word", type: "wav")
                                    }
                                }
                        )
                    }
                    .position(CGPoint(x: screenWidth/2, y: screenHeight/2))
                    
                    
                }.onAppear{
                    viewModel.playInstruction()
                }.onChange(of: isSyllableCombined) { newValue in
                    viewModel.playInstruction()
                }
            }
        }
    }
}

//#Preview {
//    CombineSyllableActivityView(learningWord: PreviewDataResources.word, onNext: { })
//}

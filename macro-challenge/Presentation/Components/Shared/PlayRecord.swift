//
//  PlayRecord.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 29/10/23.
//

import SwiftUI

struct PlayRecord: View {
    
    // Play Record
    @State var action : () -> Void
    @Binding var drawingHeight: Bool
    @State var isRunning = false
    @State var repeatRecord = false
    @Binding var isDone : Bool
    
    // Progress bar
    @State var progress : CGFloat = 0.0
    let timer = Timer.publish(every: 0.1, on:.main, in: .common).autoconnect()
    @State private var tapCount = 0
    @State private var isProgressCompleted = false
    
    
    // Animation
    var animation: Animation {
        return .linear(duration: 0.5).repeatForever()
    }
    
    var body: some View {
        
        VStack{
            
            Button(action: {
                
                if tapCount == 0 {
                    // Start animation -> first tap
                    isRunning = true
                } else {
                    // Reset progress
                    progress = 0
                    isRunning = true
                }
                tapCount += 1
                action()
                self.progress = 0.0
                repeatRecord = true
            }, label: {
                // MARK: Progress Bar
                VStack {
                    Image(systemName: "play.fill")
                        .foregroundColor(Color.Blue1)
                        .font(Font.system(size: 50, weight: .bold))
                        .padding()
                    
                    RecordProgressBarView(progress: progress)
                        .frame(height: 5)
                        .padding(15)
                }
            })
            .onReceive(timer) { _ in
                if isRunning && progress < 1.0 {
                    progress += 0.025
                    if progress >= 1.0 {
                        isDone = true
                    }
                }
            }
            
            
        }
        .buttonStyle(PonoButtonStyle(variant: .secondary))
        
    }
    // Animated Play Record
    func bar(low: CGFloat = 0.0, high: CGFloat = 1.0) -> some View {
        RoundedRectangle(cornerRadius: 3)
            .fill(Color.White1)
            .frame(height: (drawingHeight ? high : low) * 64)
            .frame(height: 64, alignment: .center)
    }
    
}

struct PlayRecord_Previews: PreviewProvider {
    static var previews: some View {
        PlayRecord(action: {}, drawingHeight: .constant(false), isDone: .constant(false))
    }
}

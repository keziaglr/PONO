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
    @Binding var isDone: Bool
    
    // Progress bar
    @State var progress: CGFloat = 0.0
    @State var currentTime: TimeInterval?
    @Binding var duration: TimeInterval?
    let timer = Timer.publish(every: 0.1, on:.main, in: .common).autoconnect()
    
    var body: some View {
        
        VStack{
            
            Button(action: {
                progress = 0
                currentTime = 0.0
                action()
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
                if let duration, let currentTime, progress <= 1 {
                    self.currentTime = currentTime + 0.1
                    progress = currentTime / duration
                    
                    if currentTime > 0, progress > 1.0 {
                        isDone = true
                        self.currentTime = nil
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
        PlayRecord(action: {}, drawingHeight: .constant(false), isDone: .constant(false), duration: .constant(0.0))
    }
}

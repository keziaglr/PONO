//
//  RecordingAudio.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 30/10/23.
//

import SwiftUI

struct RecordingAudio: View {
    
    @State private var animateInner: Bool = false
    @State private var animateOuter: Bool = false
    
    @Binding var pronunciationStatus: RecordingStatus
    
    var body: some View {
        ZStack {
            
            Circle()
                .frame(width: 300)
                .foregroundColor(pronunciationStatus.colorAnimation)
                .scaleEffect(animateInner ? 1 : 0.9)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(0.5),
                           value: animateInner)
                .opacity(pronunciationStatus == .recording ? 1 : 0)
            
            Circle()
                .frame(width: 290)
                .foregroundColor(pronunciationStatus.colorAnimation)
                .scaleEffect(pronunciationStatus == .recording ? 1 : 1.2)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(0.5),
                           value: animateOuter)
                .opacity(pronunciationStatus == .recording ? 1 : 0)
            
            Circle()
                .frame(width: 120, height: 115)
                .foregroundColor(pronunciationStatus.color)
            
            Image(systemName: pronunciationStatus.images)
                .font(.system(size: 65, weight: .semibold))
                .animation(Animation.easeInOut(duration: 0.5), value: pronunciationStatus == .recording)
                .foregroundColor(pronunciationStatus == .idle ? Color.Grey3 : Color.White1)
                .scaledToFit()
            
        }
        .onChange(of: pronunciationStatus) { newValue in
            if pronunciationStatus == .recording {
                animateInner = true
            }
        }
    }
}

//
//  RecordingAudio.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 30/10/23.
//

import SwiftUI

struct RecordingAudio: View {
    @Binding var record : Bool
    @State var animateInner : Bool = false
    @State var animateOuter : Bool = false
    
    var body: some View {
        ZStack {
            
            Circle()
                .frame(width: 300)
                .foregroundColor(Color.Blue3)
                .scaleEffect(animateInner ? 1 : 0.9)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(0.5), value: animateInner)
                .onAppear{
                    animateInner.toggle()
                }
                .opacity(record ? 1 : 0)
            Circle()
                .frame(width: 290)
                .foregroundColor(Color.Blue2.opacity(0.5))
                .scaleEffect(record ? 1 : 1.2)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(0.5), value: animateOuter)
                .onAppear{
                    animateOuter.toggle()
                }
                .opacity(record ? 1 : 0)
            Circle()
                .frame(width: 100)
                .foregroundColor(Color.Blue3)
                .opacity(record ? 1 : 0)
            Image(systemName: record ? "mic.fill" : "mic.slash.fill")
                .resizable()
                .animation(Animation.easeInOut(duration: 0.5), value: record)
                .foregroundColor(record ? Color.Blue1 : Color.Grey3)
                .scaledToFit()
            .frame(width: 60, height: 60)
            
        }
    }
}

struct RecordingAudio_Previews: PreviewProvider {
    static var previews: some View {
        RecordingAudio(record: .constant(true))
    }
}
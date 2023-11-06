//
//  RecordingAudio.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 30/10/23.
//

import SwiftUI

struct RecordingAudio: View {
    @Binding var record: Bool
    @State var animateInner: Bool = false
    @State var animateOuter: Bool = false
    
    @Binding var recordingStatus: RecordingStatus
    
    var body: some View {
        ZStack {
                Circle()
                    .frame(width: 300)
                    .foregroundColor(recordingStatus.colorAnimation)
                    .scaleEffect(animateInner ? 1 : 0.9)
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(0.5), value: animateInner)
                    .onAppear {
                        if recordingStatus == .recording {
                                    animateInner = true
                                }
                    }
                    .opacity(record ? 1 : 0)
                Circle()
                    .frame(width: 290)
                    .foregroundColor(recordingStatus.colorAnimation)
                    .scaleEffect(record ? 1 : 1.2)
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(0.5), value: animateOuter)
                    .onAppear {
                        if recordingStatus == .recording {
                                    animateInner = true
                                }
                    }
                    .opacity(record ? 1 : 0)
            
            Circle()
                .frame(width: 120, height: 115)
                .foregroundColor(recordingStatus.color)
            
            Image(systemName: recordingStatus.images)
                .font(.system(size: 65, weight: .semibold))
                .animation(Animation.easeInOut(duration: 0.5), value: record)
                .foregroundColor(recordingStatus == .idle ? Color.Grey3 : Color.White1)
                .scaledToFit()
        }
    }
}

struct RecordingAudio_Previews: PreviewProvider {
    static var previews: some View {
        RecordingAudio(record: .constant(true), recordingStatus: .constant(.recording))
    }
}

//struct RecordingAudio: View {
//    @Binding var record : Bool
//    @State var animateInner : Bool = false
//    @State var animateOuter : Bool = false
//
//    @State var isRecording = true
//    @State var isTrue = false
//
//    var body: some View {
//        ZStack {
//
//            Circle()
//                .frame(width: 300)
//                .foregroundColor(isRecording ?Color.Blue1.opacity(0.2) : .clear)
//                .scaleEffect(animateInner ? 1 : 0.9)
//                .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(0.5), value: animateInner)
//                .onAppear{
//                    animateInner.toggle()
//                }
//                .opacity(record ? 1 : 0)
//            Circle()
//                .frame(width: 290)
//                .foregroundColor(isRecording ?Color.Blue1.opacity(0.2) : .clear)
//                .scaleEffect(record ? 1 : 1.2)
//                .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(0.5), value: animateOuter)
//                .onAppear{
//                    animateOuter.toggle()
//                }
//                .opacity(record ? 1 : 0)
//            Circle()
//                .frame(width: 100)
//                .foregroundColor(Color.Blue1)
//                .opacity(record ? 1 : 0)
//            Image(systemName: record ? "mic.fill" : "mic.slash.fill")
//                .resizable()
//                .animation(Animation.easeInOut(duration: 0.5), value: record)
//                .foregroundColor(record ? Color.White1 : Color.Grey3)
//                .scaledToFit()
//            .frame(width: 60, height: 60)
//
//        }
//    }
//}

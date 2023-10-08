//
//  BelajarKata.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 08/10/23.
//


import SwiftUI

struct SpeechView: View {
    @Environment(\.scenePhase) var scenePhase
    @Binding var page : Int
    @State var mc = MusicController()
    
    @StateObject var speechRecognizer = SpeechRecognizer()
    // You’ll use this variable in the next section to display recording indicators
    @State var isRecording = false
    @State var speakTimer = 3
    
    @State var isActive = true
    
    //    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var imageIndex = 0
    let images = ["microphone-off", "microphone-on", "correct-answer", "wrong-answer"]
    
    
    
    var userAnswer = ""
    var body: some View {
        ZStack {
            
            VStack {
                Text(speechRecognizer.transcript)
                    .font(.system(size: 20, weight: .bold))
                
                //                Text("Time \(speakTimer)")
                //                    .font(.system(size: 18, weight: .semibold))
                HStack(spacing: 20) {
                    Text("B U K U")
                        .font(Font.custom("Quicksand-bold", size: 64))
                        .shadow(color: .white, radius: 0.4)
                        .foregroundColor(Color("speech-word-eg"))
                    
                    Button {
                        print("Edit button was tapped")
                        mc.playSound()
                    } label: {
                        Image("pronounce-btn")
                    }
                }
                
                
                
                Text("B U K U")
                    .font(Font.custom("Quicksand-bold", size: 200))
                    .shadow(color: .white, radius: 0.4)
                    .foregroundColor(imageIndex == 2 ? Color("correct-speech"): Color("word-color"))
                
                
                // MARK: Speech recording
                Button(action: {
                    if !isRecording {
                        imageIndex = 1
                        speechRecognizer.startTranscribing()
                        
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                            speakTimer -= 1
                            
                            if speakTimer <= 0 {
                                timer.invalidate() // Stop the timer when 0
                                speechRecognizer.stopTranscribing()
                                
                                // set isRecording to false
                                isRecording = false
                                
                                // reset the speakTimer to default
                                speakTimer = 5
                                
                                let transcript = String(speechRecognizer.transcript).lowercased()
                                
                                // MARK: Validate speech
                                if transcript == "buku" {
                                    imageIndex = 2
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                        page = 2
                                    }
                                    print("Mantap Betol")
                                } else if transcript != "buku" {
                                    imageIndex = 3
                                    print("Kurang beruntung ANDA!")
                                }
                                print(speechRecognizer.transcript)
                                
                            }
                            
                        }
                        
                    }
                    isRecording.toggle()
                    
                }) {
                    Image(images[imageIndex])
                        .resizable()
                        .frame(width: 135, height: 135)
                    
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color("bg-color"), ignoresSafeAreaEdges: .all)
        //        .onReceive(timer) { time in
        //            if speakTimer > 0 {
        //                speakTimer -= 1
        //            }
        //        }
        //        .padding()
        
        
    }
}

//#Preview {
//    BelajarKata()
//}

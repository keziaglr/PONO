//
//  RecordingListView.swift
//  macro-challenge
//
//  Created by Rio Johanes Sumolang on 23/10/23.
//

import SwiftUI

struct recordingListView: View {
    
    @ObservedObject var vm = VoiceViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    
                }) {
                    Image(systemName: "gear")
                        .foregroundColor(.black)
                        .font(.system(size: 67, weight: .bold))
                        .padding()
                }
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 830, height: 20)
                
                Spacer()
                
                Button(action: {
                    if vm.isRecording == true {
                        vm.stopRecording()
                    }
                    vm.fetchAllRecording()
                }) {
                    Image(systemName: "questionmark.app")
                        .foregroundColor(.black)
                        .font(.system(size: 67, weight: .bold))
                }
            }.padding(20)

            Button(action: {
                // Add the action you want to perform when the HStack is clicked
                
            }) {
                
                HStack {
                    Spacer()
                        .frame(width: 65)
                    
                    Image("speak-wf")
                        .resizable()
                        .frame(width: 326, height: 334)
                    
                    Spacer()
                    
                    Image("speak-wf")
                        .resizable()
                        .frame(width: 326, height: 334)
                        .scaleEffect(x: -1, y: 1)
                    
                    Spacer()
                        .frame(width: 65)
                }
                
            }
            

            
            
            Spacer()
        }
        

//                            Button(action: {
//                                if recording.isPlaying == true {
//                                    vm.stopPlaying(url: recording.fileURL)
//                                }else{
//                                    vm.startPlaying(url: recording.fileURL)
//                                }
//                            }) {
//                                Image(systemName: recording.isPlaying ? "stop.fill" : "play.fill")
//                                    .foregroundColor(.white)
//                                    .font(.system(size:30))
//                            }
                            
//
    }
}



struct recordingListView_Previews: PreviewProvider {
    static var previews: some View {
        recordingListView()
    }
}

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
                }
                
                Spacer()
                
                Rectangle()
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
            Spacer()
        }
        ScrollView(showsIndicators: false){
            ForEach(vm.recordingsList, id: \.createdAt) { recording in
                VStack{
                    HStack{
                        Image(systemName:"headphones.circle.fill")
                            .font(.system(size:50))
                        
                        VStack(alignment:.leading) {
                            Text("\(recording.fileURL.lastPathComponent)")
                        }
                        VStack {
                            Button(action: {
                                vm.deleteRecording(url:recording.fileURL)
                            }) {
                                Image(systemName:"xmark.circle.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size:15))
                            }
                            Spacer()
                            
                            Button(action: {
                                if recording.isPlaying == true {
                                    vm.stopPlaying(url: recording.fileURL)
                                }else{
                                    vm.startPlaying(url: recording.fileURL)
                                }
                            }) {
                                Image(systemName: recording.isPlaying ? "stop.fill" : "play.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size:30))
                            }
                            
                        }
                        
                    }.padding()
                }.padding(.horizontal,10)
                    .frame(width: 370, height: 85)
                    .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                    .cornerRadius(30)
                    .shadow(color: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)).opacity(0.3), radius: 10, x: 0, y: 10)
            }
        }.padding(.top,30)
            .navigationBarTitle("Recordings")
    }
}



struct recordingListView_Previews: PreviewProvider {
    static var previews: some View {
        recordingListView()
    }
}

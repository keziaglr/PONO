//
//  ContentView.swift
//  macro-challenge
//
//  Created by Rio Johanes Sumolang on 23/10/23.
//

import SwiftUI

struct RecordingView: View {
    
    @ObservedObject var vm = VoiceViewModel()
    
    @State private var showingList = false
    
    var body: some View {
        ZStack{
            VStack{
                HStack {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "gear")
                            .foregroundColor(.black)
                            .font(.system(size: 67, weight: .bold))
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
                        showingList.toggle()
                    }) {
                        Image(systemName: "questionmark.app")
                            .foregroundColor(.black)
                            .font(.system(size: 67, weight: .bold))
                    }.sheet(isPresented: $showingList, content: {
                        recordingListView()
                    })
                }
                Spacer()

                               
                
                RoundedRectangle(cornerRadius: 23.0)
                    .strokeBorder(style: StrokeStyle(lineWidth: 5, dash: [55, 15])) // dash: [lineLength, lineSpacing]
                    .frame(width: 266, height: 399)
                    .foregroundColor(.black)
                
                
                Spacer()
                
                
                if vm.isRecording {
                    VStack(alignment : .leading , spacing : -5){
                        HStack (spacing : 3) {
                            Image(systemName: vm.isRecording && vm.toggleColor ? "circle.fill" : "circle")
                                .font(.system(size:10))
                                .foregroundColor(.red)
                            Text("Rec")
                        }
                        Text(vm.timer)
                            .font(.system(size:60))
                            .foregroundColor(.black)
                    }
                } 
//                else {
//                    VStack{
//                        Text("Apakah kamu puas dengan hasil suaramu?")
//                            .foregroundColor(.black)
//                    }.frame(width: 300, height: 100, alignment: .center)
//                }
                    Image(systemName: vm.isRecording ? "stop.circle.fill" : "mic.circle")
                        .foregroundColor(.black)
                        .font(.system(size: 45))
                        .onTapGesture {
                            if vm.isRecording == true {
                                vm.stopRecording()
                            } else {
                                vm.startRecording()
                                
                            }
                        }
                
                
                Spacer()
                
                
                
            }
            .padding(.leading,25)
            .padding(.trailing,25)
            .padding(.top , 70)
        }.navigationTitle("Voice Record")
        
    }
}


struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingView()
    }
}

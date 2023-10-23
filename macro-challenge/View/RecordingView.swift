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
        NavigationView{
            ZStack{
                VStack{
                    Button(action: {
                        if vm.isRecording == true {
                            vm.stopRecording()
                        }
                        vm.fetchAllRecording()
                        showingList.toggle()
                    }) {
                        Image(systemName: "list.bullet")
                            .foregroundColor(.black)
                            .font(.system(size: 20, weight: .bold))
                    }.sheet(isPresented: $showingList, content: {
                        recordingListView()
                    })

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
                    } else {
                        VStack{
                            Text("Press the Recording Button below")
                                .foregroundColor(.black)
                            Text("and Stop when its done")
                                .foregroundColor(.black)
                        }.frame(width: 300, height: 100, alignment: .center)
                    }
                    ZStack {
                        Image(systemName: vm.isRecording ? "stop.circle.fill" : "mic.circle.fill")
                            .foregroundColor(.black)
                            .font(.system(size: 45))
                            .onTapGesture {
                                if vm.isRecording == true {
                                    vm.stopRecording()
                                } else {
                                    vm.startRecording()

                                }
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
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingView()
    }
}

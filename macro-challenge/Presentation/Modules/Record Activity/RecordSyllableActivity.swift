////
////  RecordSyllableActivity.swift
////  macro-challenge
////
////  Created by Kezia Gloria on 30/10/23.
////
//
//import SwiftUI
//
//struct RecordSyllableActivity: View {
//    @State var record = false
//    @ObservedObject var vm : FlowScreenViewModel
//    var body: some View {
//        VStack{
//            Spacer()
//            PronounceInstruction(syllable: ["bu"])
//            Spacer()
//            Image(systemName: record ? "mic.fill" : "mic.slash.fill")
//                .resizable()
//                .foregroundColor(Color.Grey3)
//                .scaledToFit()
//                .frame(width: 75, height: 75)
//                .onTapGesture {
//                    self.record = true
//                    RecordingManager.shared.startRecord(for: 5.0) { audioRecord in
//                        print("selesai record")
//                        self.record = false
//                    }
//                }
//        }
//    }
//}
//
//struct RecordSyllableActivity_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordSyllableActivity(vm: FlowScreenViewModel())
//    }
//}

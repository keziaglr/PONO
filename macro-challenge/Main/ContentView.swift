//
//  ContentView.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 05/10/23.
//

import SwiftUI

struct ContentView: View {
    
//    @ObservedObject var audioManager = ContentViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            
//            Button(action: {
//                
//                audioManager.startPlaying()
//                
//            }) {
//                Image(systemName: "play.fill")
//                    .foregroundColor(.black)
//                    .font(.system(size: 67, weight: .bold))
//            }
            
        }
        .padding()
//        .onAppear {
//            let data = DataFeedManager().createDataSyllables()
//        }
//        .onAppear{
//            audioManager.startRecord()
//        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

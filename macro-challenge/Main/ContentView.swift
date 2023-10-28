//
//  ContentView.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 05/10/23.
//

import SwiftUI

struct ContentView: View {
    var viewModel: ContentViewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
//        .onAppear {
//            let data = DataFeedManager().createDataSyllables()
//        }
        .onAppear{
            viewModel.playAudio()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

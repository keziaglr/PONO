//
//  RatingView.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 20/11/23.
//

import SwiftUI

struct RatingView: View {
    var rating : Int
    
    var label = ""
    var maximumRating = 3
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.Grey3
    var onColor = Color.Yellow2
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                    image(for: number)
                        .foregroundStyle(number > rating ? offColor : onColor)
            }
        }
        .padding(5)
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            offImage ?? onImage
        } else {
            onImage
        }
    }
}

    #Preview {
        RatingView(rating: 3)
    }

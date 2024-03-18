//
//  RatingView.swift
//  YassirRider
//
//  Created by Mac on 18/03/2024.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var label =  ""
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.circle.fill")
    
    var onColor = Color.primaryColor
    var offColor = Color.secondaryText

    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }

            ForEach(1..<maximumRating + 1, id: \.self) { number in
                Button {
                    rating = number
                } label: {
                    image(for: number)
                        .font(.system(size: 30))
                        .foregroundStyle(number > rating ? offColor : onColor)
                }
            }
        }
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
    RatingView(rating: .constant(3))
}

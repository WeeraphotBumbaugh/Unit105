//  StarRatingView.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/13/25.
import SwiftUI

struct StarRatingView: View {
    @Binding var rating: Int
    
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) {star in
                Button(action: {
                    rating = star
                }) {
                    Image(systemName: star <= rating ? "star.fill" : "star")
                        .font(.title2)
                }.buttonStyle(.plain)
            }
        }
        .accessibilityElement(children: .ignore) // Ignore individual star buttons
        .accessibilityLabel("Star rating") // Provide a single label for the whole control
        .accessibilityValue("\(rating) out of 5 stars") // Anounce current value
        .accessibilityAdjustableAction { direction in // Allow value changing with swipes
            switch direction {
            case .increment:
                if rating < 5 { rating += 1 }
            case .decrement:
                if rating > 1 { rating -= 1 }
            default:
                break
            }
        }
    }
}

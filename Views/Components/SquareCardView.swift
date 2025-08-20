//  SquareCardView.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/18/25.
import SwiftUI

struct SquareCardView: View {
    let book: Book
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Background image with subtle overlay for readability
            Image(book.image)
                .resizable()
                .scaledToFill()
                .overlay(Color.black.opacity(0.25))
                .clipped()
            
            VStack(spacing: 6) {
                Spacer()
                
                // Title with frosted glass background
                Text(book.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
                
                // Author chip
                Text(book.author)
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.9))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        Capsule().fill(Color.black.opacity(0.5))
                    )
                
                // Genre chip
                Text(book.genre.rawValue)
                    .font(.caption2)
                    .foregroundColor(.white)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(
                        Capsule().fill(Color.blue.opacity(0.7))
                    )
                    .padding(.bottom, 6)
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.25), radius: 8, x: 0, y: 4)
    }
}

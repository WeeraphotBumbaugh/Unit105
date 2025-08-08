//  DetailView.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/6/25.
import SwiftUI

struct DetailView: View {
    let book: Book

    var body: some View {
        VStack(spacing: 20) {
            Text(book.title)
                .font(.largeTitle)
                .fontWeight(.bold)

            Image(book.image)
                .resizable()
                .scaledToFit()
                .frame(height: 200)

            Text(book.description)
                .padding()
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

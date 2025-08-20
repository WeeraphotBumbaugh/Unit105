//  LinkView.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/6/25.
import SwiftUI

struct LinkView: View {
    let book: Book
    
    var body: some View {
        HStack{
            Image(book.image)
                .resizable()
                .frame(maxWidth: 48, maxHeight: 48)
                .scaledToFit()
                .accessibilityLabel("\(book.title) book cover")
            Text(book.title)
        }
    }
}

//  LinkView.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/6/25.
import SwiftUI

struct LinkView: View {
    let item: Book
    
    var body: some View {
        HStack{
            Image(item.image)
                .resizable()
                .frame(maxWidth: 48, maxHeight: 48)
                .scaledToFit()
                .accessibilityLabel("\(item.title) book cover")
            Text(item.title)
        }
    }
}

//  LinkView.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/6/25.
import SwiftUI
import SwiftData

struct LinkView: View {
    let book: Book
    
    @Environment(\.modelContext) var modelContext
    var bookImage: UIImage? {
        guard let imageId = book.imageId,
              let imageModel = modelContext.model(for: imageId) as? UploadedImage,
              let imageData = imageModel.imageData! as Data? else {
            return UIImage(systemName: "book")
        }
        return UIImage(data: imageData)
    }
    
    var body: some View {
        HStack{
            Image(uiImage: bookImage!)
                .resizable()
                .frame(maxWidth: 48, maxHeight: 48)
                .scaledToFit()
                .accessibilityLabel("\(book.title) book cover")
            Text(book.title)
        }
    }
}

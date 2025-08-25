//  EditView.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/11/25.
import SwiftUI
import PhotosUI
import SwiftData

struct EditView: View {
    
    @Binding var book: Book
    @State private var bookCopy: Book
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @State private var navigationTitle: String
    @State private var photoPickerItem: PhotosPickerItem?
    @State var bookImage: UIImage?
    @State var bookImageCover: UIImage?
    
    // A custom initializer to set the title when the view is first created.
    init(book: Binding<Book>) {
        // The underscore '_book' refers to the Binding property wrapper itself.
        self._book = book
        // The underscore '_navigationTitle' refers to the State property wrapper.
        // We set it's initial value based on the book's state at this moment.
        self._navigationTitle = State(initialValue: book.wrappedValue.title.isEmpty ? "Add Book" : "Edit Book")
        self._bookCopy = State(initialValue: book.wrappedValue)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Book Cover")) {
                    ImageField(image: $bookImage)
                    ImageField(image: $bookImageCover)
                }
                
                Section(header: Text("Book Details")) {
                    TextField("Title", text: $book.title)
                    TextField("Author", text: $book.author)
                    
                    Picker("Status", selection: $book.status){
                        ForEach(ReadingStatus.allCases, id: \.self) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    Picker("Genre", selection: $book.genre){
                        ForEach(Genre.allCases, id: \.self) { genre in
                            Text(genre.rawValue).tag(genre)
                        }
                    }
                    TextEditor(text: $book.description)
                        .frame(height: 150)
                }
                
                Section(header: Text("My Rating & Review")) {
                    StarRatingView(rating: $book.rating)
                    // TextEditor is for multi-line text input.
                    TextEditor(text: $book.review)
                        .frame(height: 150)
                }
            }
            .navigationTitle(navigationTitle)
            .toolbar{
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if bookImage != nil {
                            let newUploadedImage = UploadedImage(imageData: bookImage?.jpegData(compressionQuality: 0.8))
                            modelContext.insert(newUploadedImage)
                            do {
                                try modelContext.save()
                            } catch {
                                print("Erorr while saving the image: \(error)")
                            }
                            bookCopy.imageId = newUploadedImage.persistentModelID
                            let _ = print("New image id: \(bookCopy.imageId)")
                        }
                        book = bookCopy
                        dismiss()
                    }
                }
            }
        }
    }
}


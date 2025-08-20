//  BookListView.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/16/25.
import SwiftUI

struct BookListView: View {
    
    @Binding var books: [Book]
    @State private var showingAddBookSheet = false
    
    @State private var newBook = Book(
        title: "",
        author: "",
        image: "default-book",
        description: "",
        rating: 0,
        review: "",
        status: .planToRead,
        genre: .fantasy
    )
    
    var body: some View {
        NavigationStack{
            List($books){ $book in
                NavigationLink(destination:
                                DetailView(book: $book)){
                    LinkView(book: book)
                }
                .accessibilityHint("Click for detail view of \(book.title)")
            }
        .navigationTitle("My Books")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showingAddBookSheet = true }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                }
                .accessibilityLabel("Add new book")
            }
        }
        .accessibilityAddTraits(.isHeader)
        .sheet(isPresented: $showingAddBookSheet) {
            if !newBook.title.isEmpty {
                books.append(newBook)
            }
            newBook = Book(
                title: "",
                author: "",
                image: "default-book",
                description: "",
                rating: 0,
                review: "",
                status: .planToRead,
                genre: .fantasy)
        } content: {
                EditView(book: $newBook)
            }
        }
    }
}

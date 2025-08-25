//  BookListView.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/16/25.
import SwiftUI

struct BookListView: View {
    
    @Binding var books: [Book]
    @State private var activeSheet: ActiveSheet? = nil
    @State var selectedGenre: Genre?
    @State var selectedStatus: ReadingStatus?
    @State private var newBook = NEW_BOOK
    
    private var filteredBooks: [Book] {
        books.filter { book in
            var matches = true
            if let genre = selectedGenre {
                matches = matches && book.genre == genre
            }
            if let status = selectedStatus {
                matches = matches && book.status == status
            }
            return matches
        }
    }
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(filteredBooks, id: \.id) { book in
                    if let index = books.firstIndex(where: { $0.id == book.id }){
                        NavigationLink(destination:
                                        DetailView(book: $books[index])){
                            LinkView(book: book)
                        }
                        .accessibilityHint("Click for detail view of \(book.title)")
                    }
                }
            }
        .navigationTitle("My Books")
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button(action: { activeSheet = .addBook }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                }
                .accessibilityLabel("Add new book")
            }
            ToolbarItemGroup(placement: .topBarLeading) {
                Button("Filter") { activeSheet = .filter }
                    .accessibilityLabel("Filter button")
                    .accessibilityHint("Click to filter")
            }
        }
        .accessibilityAddTraits(.isHeader)
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .addBook:
                EditView(book: $newBook)
                    .onDisappear {
                        if !newBook.title.isEmpty {
                            books.append(newBook)
                        }
                        newBook = Book(
                            title: "",
                            author: "",
//                            image: "default-book",
                            description: "",
                            rating: 0,
                            review: "",
                            status: .planToRead,
                            genre: .fantasy
                        )
                    }
            case .filter:
                FilterView(
                    selectedGenre: $selectedGenre,
                    selectedStatus: $selectedStatus
                )
                }
            }
        }
    }
}

//  FavoritesView.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/16/25.
import SwiftUI

struct FavoritesView: View {

    @Binding var books: [Book]
    @State var showingFilterSheet = false
    @State var selectedGenre: Genre?
    @State var selectedStatus: ReadingStatus?

    let gridLayout = [GridItem(), GridItem()]
    
    private var favoriteBooks: [Binding<Book>] {
        $books.filter { $0.wrappedValue.isFavorite &&
            (selectedGenre == nil || $0.wrappedValue.genre == selectedGenre!) &&
            (selectedStatus == nil || $0.wrappedValue.status == selectedStatus!)
        }
    }

    var body: some View {
        NavigationStack{
            ScrollView{
                if favoriteBooks.isEmpty {
                    Text("No favorite books yet!")
                } else {
                    LazyVGrid(columns: gridLayout){
                        ForEach(favoriteBooks) { book in
                            NavigationLink(value: book.id){
                                SquareCardView(book: book.wrappedValue)
                            }
                        }
                        .padding(2)
                    }
                    
                }
            } // ScrollView
            .navigationTitle("Favorites")
            .navigationDestination(for: UUID.self){ bookId in
                if let bookIndex = books.firstIndex(where: {$0.id == bookId}){
                    DetailView(book: $books[bookIndex])
                } else {
                    Text("Book not found")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Filter") { showingFilterSheet = true }
                    .accessibilityLabel("Filter button")
                    .accessibilityHint("Click to filter")
                }
            }
            .sheet(isPresented: $showingFilterSheet) {
                FilterView(
                    selectedGenre: $selectedGenre,
                    selectedStatus: $selectedStatus
                )
            }
            .padding()
        } // NavigationStack
    } // View
}

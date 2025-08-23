//  FavoritesView.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/16/25.
import SwiftUI

struct FavoritesView: View {
    
    @Binding var books: [Book]
    @State var showingFilterSheet = false
    @State var selectedGenre: Genre?
    @State var selectedStatus: ReadingStatus?
    @AppStorage(SETTINGS_GRID_COLUMN_NUMBERS_KEY) private var gridColumnNumber: Int = 2
    
    //    private var gridLayout: [GridItem] {
    //        Array(repeating: GridItem(.flexible(), spacing: 12), count: gridColumnNumber)
    //    }
    private let hPad: CGFloat = 16 // Horizontal padding for grid area
    private let cellSpacing: CGFloat = 12
    
    private var favoriteBooks: [Binding<Book>] {
        $books.filter { $0.wrappedValue.isFavorite &&
            (selectedGenre == nil || $0.wrappedValue.genre == selectedGenre!) &&
            (selectedStatus == nil || $0.wrappedValue.status == selectedStatus!)
        }
    }
    
    var body: some View {
        NavigationStack{
            ScrollView{
                // Compute side using screen width
                let columns = max(1, gridColumnNumber)
                let totalSpacing = cellSpacing * CGFloat(columns - 1)
                let availableWidth = UIScreen.main.bounds.width - (hPad * 2) - totalSpacing
                let side = floor(availableWidth / CGFloat(columns))
                
                if favoriteBooks.isEmpty {
                    Text("No favorite books yet!")
                        .frame(maxWidth: .infinity, minHeight: 200)
                }
                    
                LazyVGrid(
                    columns: Array(repeating: GridItem(.fixed(side), spacing: cellSpacing, alignment: .top), count: columns),
                    spacing: cellSpacing
                ) {
                    ForEach(favoriteBooks, id: \.wrappedValue.id) { book in
                        // Because I'm using book.id from favoriteBooks, it's of type Binding<Book>, so I need book.wrappedValue.id instead of book.id
                        NavigationLink(value: book.wrappedValue.id){
                            SquareCardView(book: book.wrappedValue)
                                .frame(width: side, height: side * 1.5) // Hard Square
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, hPad)
                .padding(.vertical, 8)
                
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
                    // .navigationBarLeading is getting deprecated
                    ToolbarItem(placement: .topBarLeading) {
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
            } // NavigationStack
        } // View
    }
}

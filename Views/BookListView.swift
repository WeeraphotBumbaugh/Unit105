//  BookListView.swift
//  Class105
import SwiftUI
import SwiftData

struct BookListView: View {
    @Query(sort: [SortDescriptor(\PersistentBook.title)]) private var books: [PersistentBook]
    @Environment(\.modelContext) private var ctx

    @State private var activeSheet: ActiveSheet? = nil
    @State private var selectedGenre: Genre?
    @State private var selectedStatus: ReadingStatus?

    // Simple in-memory filtering; nil == "All"
    private var filteredBooks: [PersistentBook] {
        books.filter { b in
            (selectedGenre == nil || b.genre == selectedGenre!) &&
            (selectedStatus == nil || b.status == selectedStatus!)
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredBooks) { book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        LinkViewPersistent(book: book)
                    }
                    .accessibilityHint("Click for detail view of \(book.title)")
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("My Books")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Filter") { activeSheet = .filter }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 16) {
                        EditButton() // enables swipe-to-delete UI
                        Button { activeSheet = .addBook } label: {
                            Image(systemName: "plus.circle.fill").font(.title2)
                        }
                        .accessibilityLabel("Add new book")
                    }
                }
            }
            .sheet(item: $activeSheet) { sheet in
                switch sheet {
                case .addBook:
                    EditView() // add mode
                case .filter:
                    FilterView(selectedGenre: $selectedGenre, selectedStatus: $selectedStatus)
                }
            }
        }
    }

    // MARK: Delete
    private func delete(at offsets: IndexSet) {
        for i in offsets { ctx.delete(filteredBooks[i]) }
        try? ctx.save()
    }
}

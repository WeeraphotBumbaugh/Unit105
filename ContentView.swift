//  ContentView.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/6/25.
import SwiftUI

struct ContentView: View {
    
    @State private var books: [Book] = getItems()
    
    var body: some View {
        NavigationStack{
            List($books){ $book in
                NavigationLink(destination:
                                DetailView(book: $book)){
                    LinkView(item: book)
                }
                .accessibilityHint("Click for detail view of \(book.title)")
            }
        .navigationTitle("LOTR Trilogy")
        .accessibilityAddTraits(.isHeader)
        }
    }
}

#Preview {
    ContentView()
}

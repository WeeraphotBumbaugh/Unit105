//  ContentView.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/6/25.
import SwiftUI

struct ContentView: View {
    
    @State private var books: [Book] = getItems()
    
    var body: some View {
        TabView{
            BookListView(books: $books)
            .tabItem{
                Label("My Books", systemImage: "books.vertical.fill")
            }
            
            FavoritesView(books: $books)
            .tabItem{
                Label("Favorites", systemImage: "heart.fill")
            }
        }
    }
}

#Preview {
    ContentView()
}

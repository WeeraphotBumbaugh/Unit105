//  ContentView.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/6/25.
import SwiftUI

struct ContentView: View {
    
    @AppStorage(SETTINGS_THEME_KEY) private var theme: Theme = .system
    @AppStorage(SETTINGS_APP_ACCENT_COLOR_KEY) private var appAccentColor: Color = .accentColor
    @State private var books: [Book] = getItems()
    
    var colorScheme: ColorScheme? {
        switch(theme) {
        case .dark:
            return .dark
        case .light:
            return .light
        case .system:
            return nil
        }
    }
    
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
            
            SettingsView()
            .tabItem{
                    Label("Settings", systemImage: "gearshape")
            }
            ImageViewer()
            .tabItem{
                    Label("Image Viewer", systemImage: "photo")
            }
        } // TabView
        .tint(appAccentColor)
        .preferredColorScheme(colorScheme)
    }
}

#Preview {
    ContentView()
}

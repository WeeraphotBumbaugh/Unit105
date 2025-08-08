//  ContentView.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/6/25.
import SwiftUI

struct ContentView: View {
    
    let books: [Book] = getItems()
    
    var body: some View {
        NavigationStack{
            List(books){ book in
                NavigationLink(destination:
                                DetailView(book: book)){
                    LinkView(item: book)
                }
                .border(Color.red, width: 2)
            }
        .navigationTitle("LOTR Trilogy")
        .border(Color.yellow, width: 2)
        }
        .border(Color.green, width: 2)
    }
}

#Preview {
    ContentView()
}

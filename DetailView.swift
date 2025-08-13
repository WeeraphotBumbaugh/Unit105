//  DetailView.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/6/25.
import SwiftUI

struct DetailView: View {
    @Binding var book: Book
    
    @State private var showingEditSheet = false

    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.white.opacity(0.1), .gray.opacity(1)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            ScrollView{
                VStack(spacing: 30) {
                    HStack {
                        Image(book.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 100, maxHeight: 150)
                            .padding(.vertical, 20)
                            .accessibilityLabel("\(book.title) book cover")
                        VStack{
                            Text(book.title)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            Text("by \(book.author)")
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                    }
                
                    Text(book.description)
                    
                    HStack {
                        ForEach(1...5, id: \.self) { count in
                            Image(systemName: count <= book.rating ?
                                  "star.fill" : "star" )
                        }
                    }
                    .accessibilityLabel("\(book.rating) out of 5 stars")
                    
                    Text(book.status.rawValue)
                        .font(.caption).fontWeight(.bold).padding(8)
                        .background(Color.accentColor.opacity(0.2))
                        .clipShape(Capsule())
                }
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    //action here
                }) {
                    Text("Edit")
                }
                .accessibilityLabel("Edit button")
                .accessibilityHint("Click to edit this book")
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            EditView(book: $book)
        }
    }
}

#Preview {
    ContentView()
}

//  DetailView.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/6/25.
import SwiftUI
import SwiftData

struct DetailView: View {
    
    @Binding var book: Book
    @State private var showingEditSheet = false
    @Environment(\.modelContext) var modelContext
    
    var bookImage: UIImage? {
        guard let imageId = book.imageId,
              let imageModel = modelContext.model(for: imageId) as? UploadedImage,
              let imageData = imageModel.imageData! as Data? else {
            return UIImage(systemName: "book")
        }
        return UIImage(data: imageData)
    }

    var body: some View {
        ZStack{
            LinearGradient(
                gradient: Gradient(colors: [.white.opacity(0.1), .gray.opacity(1)]),
                startPoint: .top,
                endPoint: .bottom)
            .ignoresSafeArea()
            
            ScrollView{
                VStack(alignment: .leading, spacing: 30) {
                    HStack {
                        Image(uiImage: bookImage!)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 100, maxHeight: 150)
                            .padding(.vertical, 10)
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
                                    
                    HStack {
                        ForEach(1...5, id: \.self) { count in
                            Image(systemName: count <= book.rating ? "star.fill" : "star" )
                                .font(.title2)
                        }
                        Spacer()
                        
                        FavoriteToggle(isFavorite: $book.isFavorite)
                    }
                    .accessibilityLabel("\(book.rating) out of 5 stars")
                    
                    HStack {
                        Text(book.status.rawValue)
                            .font(.caption).fontWeight(.bold).padding(8)
                            .background(Color.accentColor.opacity(0.2))
                            .clipShape(Capsule())
                        
                        Text(book.genre.rawValue)
                            .font(.caption).fontWeight(.bold).padding(8)
                            .background(Color.secondary.opacity(0.2))
                            .clipShape(Capsule())
                    }
                                                            
                    if !book.description.isEmpty {
                        VStack(alignment: .leading) {
                            Text(book.description)
                        }
                    }
                    
                    if !book.review.isEmpty {
                        VStack(alignment: .leading) {
                            Text("My Review")
                                .font(.title2).fontWeight(.bold)
                            Text(book.review)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") { showingEditSheet = true }
                .accessibilityLabel("Edit button")
                .accessibilityHint("Click to edit this book")
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            EditView(book: $book)
        }
    }
}

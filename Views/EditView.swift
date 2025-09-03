//  EditView.swift
//  Class105
import SwiftUI
import SwiftData
import PhotosUI

struct EditView: View {
    private enum Mode { case add, edit }
    private let mode: Mode
    private var book: PersistentBook?

    // Env
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var ctx

    // Form state
    @State private var title: String
    @State private var author: String
    @State private var summary: String
    @State private var rating: Int
    @State private var review: String
    @State private var status: ReadingStatus
    @State private var genre: Genre
    @State private var isFavorite: Bool
    @State private var imageData: Data?
    @State private var pickerItem: PhotosPickerItem?

    // Init
    init(book: PersistentBook? = nil) {
        self.book = book
        self.mode = (book == nil) ? .add : .edit
        _title      = State(initialValue: book?.title ?? "")
        _author     = State(initialValue: book?.author ?? "")
        _summary    = State(initialValue: book?.summary ?? "")
        _rating     = State(initialValue: book?.rating ?? 0)
        _review     = State(initialValue: book?.review ?? "")
        _status     = State(initialValue: book?.status ?? .planToRead)
        _genre      = State(initialValue: book?.genre ?? .fantasy)
        _isFavorite = State(initialValue: book?.isFavorite ?? false)
        _imageData  = State(initialValue: book?.imageData)
    }

    private var canSave: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                // Cover
                Section("Book Cover") {
                    HStack(spacing: 12) {
                        BookCoverView(data: imageData)
                            .frame(width: 64, height: 64)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .accessibilityLabel("Selected cover preview")

                        PhotosPicker("Choose Cover", selection: $pickerItem, matching: .images)
                            .task(id: pickerItem) {
                                if let item = pickerItem, let data = try? await item.loadTransferable(type: Data.self) {
                                    imageData = data
                                }
                            }

                        if imageData != nil {
                            Button("Remove") { imageData = nil }
                                .foregroundStyle(.red)
                        }
                    }
                }

                // Details
                Section("Book Details") {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)

                    Picker("Status", selection: $status) {
                        ForEach(ReadingStatus.allCases, id: \.self) { s in
                            Text(s.rawValue).tag(s)
                        }
                    }
                    Picker("Genre", selection: $genre) {
                        ForEach(Genre.allCases, id: \.self) { g in
                            Text(g.rawValue).tag(g)
                        }
                    }
                    Toggle("Favorite", isOn: $isFavorite)

                    TextEditor(text: $summary)
                        .frame(height: 120)
                }

                // Rating & Review
                Section("My Rating & Review") {
                    Stepper("Rating: \(rating)", value: $rating, in: 0...5)
                    TextEditor(text: $review)
                        .frame(height: 120)
                }
            }
            .navigationTitle(mode == .add ? "Add Book" : "Edit Book")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save() }
                        .disabled(!canSave)
                }
            }
        }
    }

    // Save
    private func save() {
        do {
            switch mode {
            case .add:
                let model = PersistentBook(
                    title: title,
                    author: author,
                    imageData: imageData,
                    summary: summary,
                    rating: rating,
                    review: review,
                    status: status,
                    genre: genre,
                    isFavorite: isFavorite
                )
                ctx.insert(model)

            case .edit:
                guard let book else { return }
                // Keep uppercase rule from initializer
                book.title = title.uppercased()
                book.author = author.uppercased()
                book.summary = summary
                book.rating = rating
                book.review = review
                book.status = status
                book.genre = genre
                book.isFavorite = isFavorite
                if let imageData { book.imageData = imageData }
            }

            try ctx.save()
            dismiss()
        } catch {
            print("SAVE ERROR:", error)
        }
    }
}

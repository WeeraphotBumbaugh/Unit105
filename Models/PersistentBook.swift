//  PersistentBook.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/23/25.
import Foundation
import SwiftData

@Model
final class PersistentBook {
    var title: String
    var author: String
    @Attribute(.externalStorage) var imageData: Data?

    var summary: String           
    var rating: Int
    var review: String
    var status: ReadingStatus
    var genre: Genre
    var isFavorite: Bool

    init(
        title: String,
        author: String,
        imageData: Data? = nil,
        summary: String = "",
        rating: Int = 0,
        review: String = "",
        status: ReadingStatus = .planToRead,
        genre: Genre = .fantasy,
        isFavorite: Bool = false
    ) {
        self.title = title.uppercased()
        self.author = author.uppercased()
        self.imageData = imageData
        self.summary = summary
        self.rating = rating
        self.review = review
        self.status = status
        self.genre = genre
        self.isFavorite = isFavorite
    }
}

//  BookModel.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/6/25.
import Foundation

struct Book: Identifiable {
    let id = UUID()
    var title: String
    var author: String
    var image: String = "default-book"
    var description: String = ""
    var rating: Int = 0
    var review: String = ""
    var status: ReadingStatus = .planToRead
    var genre: Genre
    var isFavorite: Bool = false
}


//  PersistentBook.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/23/25.
import Foundation
import SwiftData

@Model
class PersistentBook {
    var title: String
    var author: String
    @Attribute(.externalStorage) var imageData: Data?
    
    init(title: String, author: String, imageData: Data?) {
        self.title = title.uppercased()
        self.author = author.uppercased()
        self.imageData = imageData
    }
}


//  BookModel.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/6/25.
import SwiftUI

struct Book: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let image: String
    let description: String
    let rating: Int
    let review: String
    let status: ReadingStatus
}


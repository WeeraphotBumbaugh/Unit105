//  Genre.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/18/25.
import Foundation

enum Genre: String, CaseIterable, Hashable, Codable {
    case classic = "Classic"
    case fantasy = "Fantasy"
    case horror = "Horror"
    case dystopian = "Dystopian"
    case scifi = "Sci-Fi"
    case nonfiction = "Non-Fiction"
    case romance = "Romance"
}

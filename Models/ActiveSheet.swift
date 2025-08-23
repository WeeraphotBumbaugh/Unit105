//  ActiveSheet.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/19/25.
import Foundation

enum ActiveSheet: Identifiable, CaseIterable, Hashable {
    case addBook
    case filter
    
    var id: Int { hashValue }
}

//  ReadingStatus.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/11/25.
import SwiftUI

enum ReadingStatus: String, CaseIterable, Hashable, Codable{
    case planToRead = "Plan to Read"
    case reading = "Reading"
    case dropped = "Dropped"
    case finished = "Finished"
}

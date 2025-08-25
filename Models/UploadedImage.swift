//  UploadedImage.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/23/25.
import SwiftData
import Foundation

@Model
class UploadedImage {
    @Attribute(.externalStorage) var imageData: Data?
    
    init(imageData: Data?) {
        self.imageData = imageData
        
    }
}

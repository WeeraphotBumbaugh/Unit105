//  BookCoverView.swift
//  Class105
//

import SwiftUI

public struct BookCoverView: View {
    public let data: Data?
    public var accessibilityLabel: String?

    public init(data: Data?, accessibilityLabel: String? = nil) {
        self.data = data
        self.accessibilityLabel = accessibilityLabel
    }

    public var body: some View {
        Image(uiImage: data.flatMap(UIImage.init(data:)) ?? UIImage(systemName: "book")!)
            .resizable()
            .scaledToFill()
            .accessibilityLabel(accessibilityLabel ?? "Book cover")
    }
}

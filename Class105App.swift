// Class105App.swift
import SwiftUI
import SwiftData

@main
struct Class105App: App {
    static let sharedModelContainer: ModelContainer = {
        do {
            // Build the old custom path
            let fm = FileManager.default
            let appSupport = try fm.url(for: .applicationSupportDirectory,
                                        in: .userDomainMask,
                                        appropriateFor: nil,
                                        create: true)
            let dir = appSupport.appendingPathComponent("SwiftData", isDirectory: true)
            try? fm.createDirectory(at: dir, withIntermediateDirectories: true)

            let legacyURL = dir.appendingPathComponent("BooksStore-v2.sqlite")

            if fm.fileExists(atPath: legacyURL.path) {
                // Use your existing store so previous data appears
                let cfg = ModelConfiguration(url: legacyURL)
                return try ModelContainer(for: PersistentBook.self, configurations: cfg)
            } else {
                // Fresh install: use default location (simpler path)
                return try ModelContainer(for: PersistentBook.self)
            }
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(Self.sharedModelContainer) // <-- single, shared instance
    }
}

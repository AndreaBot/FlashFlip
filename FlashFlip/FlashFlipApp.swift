//
//  FlashFlipApp.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 24/02/2024.
//

import SwiftUI
import SwiftData

@main
struct FlashFlipApp: App {
    
    let modelContainer: ModelContainer
        
        init() {
            do {
                modelContainer = try ModelContainer(for: FolderModel.self)
            } catch {
                fatalError("Could not initialize ModelContainer")
            }
        }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(modelContainer)
    }
}

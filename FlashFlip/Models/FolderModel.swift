//
//  FolderModel.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 24/02/2024.
//

import Foundation
import SwiftData

@Model
final class FolderModel: Identifiable {
    
    var id: Double
    var name: String
    var iconName: String
    var colorName: String
    @Relationship(deleteRule:.cascade) var decks = [DeckModel]()
    
    init(id: Double = Date.timeIntervalSinceReferenceDate, name: String, iconName: String, colorName: String) {
        self.id = id
        self.name = name
        self.iconName = iconName
        self.colorName = colorName
    }
}

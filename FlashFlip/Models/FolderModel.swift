//
//  FolderModel.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 24/02/2024.
//

import Foundation

class FolderModel: Identifiable {
    
    let id: UUID
    let name: String
    let iconName: String
    let colorName: String
    var decks = [DeckModel]()
    
    init(id: UUID, name: String, iconName: String, colorName: String) {
        self.id = UUID()
        self.name = name
        self.iconName = iconName
        self.colorName = colorName
    }
}

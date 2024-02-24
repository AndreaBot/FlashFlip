//
//  Deck Model.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 24/02/2024.
//

import Foundation
import SwiftData

@Model
final class DeckModel: Identifiable {
    
    let id: UUID
    var name: String
    var folder: FolderModel?
    var cards = [CardModel]()
    
    init(id: UUID, name: String, folder: FolderModel? = nil, cards: [CardModel]) {
        self.id = id
        self.name = name
        self.folder = folder
        self.cards = cards
    }
}

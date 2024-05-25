//
//  Deck Model.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 24/02/2024.
//

import Foundation
import SwiftData

@Model
final class DeckModel: Identifiable, Comparable {
    static func < (lhs: DeckModel, rhs: DeckModel) -> Bool {
        lhs.id < rhs.id
    }
    
    let id: Double
    var name: String
    var folder: FolderModel?
    @Relationship(deleteRule:.cascade) var cards = [CardModel]()
    
    var sessionsCount = 0
    var averageCorrectAnswers: Double = 100
    
    init(id: Double = Date.timeIntervalSinceReferenceDate, name: String, folder: FolderModel? = nil) {
        self.id = id
        self.name = name
        self.folder = folder
    }

}

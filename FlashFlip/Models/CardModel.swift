//
//  CardModel.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 24/02/2024.
//

import Foundation
import SwiftData

@Model
final class CardModel: Identifiable {
    
    let question: String
    let answer: String
    let deck: DeckModel
    
    init(question: String, answer: String, deck: DeckModel) {
        self.question = question
        self.answer = answer
        self.deck = deck
    }
}

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
    
    let id: UUID
    var question: String
    var answer: String
    
    init(id: UUID, question: String, answer: String) {
        self.id = UUID()
        self.question = question
        self.answer = answer
    }

}

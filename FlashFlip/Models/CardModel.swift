//
//  CardModel.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 24/02/2024.
//

import Foundation
import SwiftData

@Model
final class CardModel: Identifiable, Comparable {
    static func < (lhs: CardModel, rhs: CardModel) -> Bool {
        lhs.id < rhs.id
    }
    
    let id: Double
    var question: String
    var answer: String
    
    var showingAnswer = false
    var rotationAmount = 0.0
    
    var correctAnswersCount = 0
    var wrongAnswersCount = 0
    var timesAppeared: Int {
        correctAnswersCount + wrongAnswersCount
    }
    
    init(id: Double = Date.timeIntervalSinceReferenceDate, question: String, answer: String) {
        self.id = id
        self.question = question
        self.answer = answer
    }
    
}

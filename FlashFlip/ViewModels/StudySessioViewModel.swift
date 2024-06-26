//
//  StudySessioViewModel.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 21/05/2024.
//

import SwiftUI

enum Mark {
    case correct, wrong, neutral
}

@Observable
final class StudySessionViewModel {
    
    let deck: DeckModel
    var studyCards: [CardModel]
    var correctAnswers = [CardModel]()
    var wrongAnswers = [CardModel]()
    var studySessionIndex: Int {
        studyCards.count - 1
    }
    var sessionCorrectPercentage = 0.0
    var mark: Mark
    
    let practisingWeakCards: Bool
    
    init(deck: DeckModel, studyCards: [CardModel], correctAnswers: [CardModel] = [CardModel](), wrongAnswers: [CardModel] = [CardModel](), sessionCorrectPercentage: Double = 0, practisingWeakCards: Bool, mark: Mark) {
        self.deck = deck
        self.studyCards = studyCards
        self.correctAnswers = correctAnswers
        self.wrongAnswers = wrongAnswers
        
        self.sessionCorrectPercentage = sessionCorrectPercentage
        self.practisingWeakCards = practisingWeakCards
        self.mark = mark
    }
    
    func progressGame() {
        if !studyCards.isEmpty {
            if mark == .correct {
                correctAnswers.append(studyCards[studySessionIndex])
            } else if mark == .wrong {
                wrongAnswers.append(studyCards[studySessionIndex])
            }
            withAnimation(.easeOut(duration: 0.6)) {
                self.studyCards.remove(at: self.studySessionIndex)
            }
            mark = .neutral
        }
    }
    
    func startNewSession() {
        correctAnswers.removeAll()
        wrongAnswers.removeAll()
        if !practisingWeakCards {
            studyCards = deck.cards.shuffled()
        }
        sessionCorrectPercentage = 0
        for card in studyCards {
            card.rotationAmount = 0
            card.showingAnswer = false
        }
    }
    
    func calculateSessionCorrectAnswersPercentage() {
        sessionCorrectPercentage = Double((100 * correctAnswers.count)/deck.cards.count)
    }
    
    func calculateDeckAverageCorrectAnswers() {
        deck.averageCorrectAnswers = (deck.averageCorrectAnswers + sessionCorrectPercentage) / 2
    }
    
    func calculateCardScores() {
        for card in correctAnswers {
            card.correctAnswersCount += 1
        }
        for card in wrongAnswers {
            card.wrongAnswersCount += 1
        }
    }
    
    static func createWeakCardsSession(deck: DeckModel) -> [CardModel] {
        var weakCards = [CardModel]()
        for card in deck.cards {
            if card.timesAppeared > 0 {
                let correctAnswersPercentage = (100 * card.correctAnswersCount) / card.timesAppeared
                if correctAnswersPercentage <= 50 {
                    weakCards.append(card)
                }
            }
        }
        return weakCards
    }
}



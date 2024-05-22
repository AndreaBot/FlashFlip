//
//  StudySessioViewModel.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 21/05/2024.
//

import Foundation

@Observable
final class StudySessionViewModel {
    
    let deck: DeckModel
    var studyCards = [CardModel]()
    var correctAnswers = [CardModel]()
    var wrongAnswers = [CardModel]()
    var studySessionIndex = 0
    
    init(deck: DeckModel, studyCards: [CardModel] = [CardModel](), correctArray: [CardModel] = [CardModel](), wrongArray: [CardModel] = [CardModel]()) {
        self.deck = deck
        self.studyCards = studyCards
        self.correctAnswers = correctArray
        self.wrongAnswers = wrongArray
    }
    
    func progressGame(mark: String) {
        if mark == "correct" {
            correctAnswers.append(studyCards.last!)
        } else if mark == "wrong" {
            wrongAnswers.append(studyCards.last!)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.studyCards.remove(at: self.studySessionIndex)
            self.studySessionIndex -= 1
        }
    }
    
    func startNewSession() {
        correctAnswers.removeAll()
        wrongAnswers.removeAll()
        studyCards.append(contentsOf: deck.cards.shuffled())
        studySessionIndex = studyCards.count - 1
        for card in studyCards {
            card.rotationAmount = 0
            card.swipeAmount = 0
            card.showingAnswer = false
        }
    }
}



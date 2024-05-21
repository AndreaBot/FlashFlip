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
            self.studyCards.removeLast()
        }
    }
    
    func startNewSession() {
        correctAnswers.removeAll()
        wrongAnswers.removeAll()
        studyCards.append(contentsOf: deck.cards.shuffled())
    }
}




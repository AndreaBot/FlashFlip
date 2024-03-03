//
//  StudySessionView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 02/03/2024.
//

import SwiftUI

struct StudySessionView: View {
    
    let deck: DeckModel
    
    @State private var swipeAmount = 0.0
    @State private var studyCards = [CardModel]()
    @State private var correctArray = [CardModel]()
    @State private var wrongArray = [CardModel]()
    
    
    var body: some View {
        NavigationStack {
            if !studyCards.isEmpty {
                CardsStackView(deck: deck, correctArray: $correctArray, wrongArray: $wrongArray, studyCards: $studyCards)
            } else {
                EndView( correctArray: $correctArray, wrongArray: $wrongArray, studyDeck: $studyCards, deck: deck)
            }
        }
        .onAppear {
            studyCards.append(contentsOf: deck.cards.shuffled())
        }
        .navigationTitle("Study Session")
    }
}

#Preview {
    StudySessionView(deck: DeckModel(id: UUID(), name: "Test"))
}

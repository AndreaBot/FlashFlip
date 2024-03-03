//
//  CardsStackView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 03/03/2024.
//

import SwiftUI


struct CardsStackView: View {
    
    let deck: DeckModel
    @Binding var correctArray: [CardModel]
    @Binding var wrongArray: [CardModel]
    
    @Binding var studyCards: [CardModel]
    
    var body: some View {
        ZStack {
            ForEach(0..<studyCards.count, id: \.self) { index in
                StudySessionCard(card: deck.cards[index], color: index == (studyCards.count - 1) ? Colors.setColor(using: deck.folder!.colorName) : Color.gray, array: $studyCards, correctGuesses: $correctArray, wrongGuesses: $wrongArray)
            }
        }
        .padding()
    }
}

#Preview {
    let correctArray = [CardModel(id: UUID(), question: "correct", answer: "correct")]
    let wrongArray = [CardModel(id: UUID(), question: "wrong", answer: "wrong")]
    
    return CardsStackView(deck: DeckModel(id: UUID(), name: "Test"), correctArray: .constant(correctArray), wrongArray: .constant(wrongArray), studyCards: .constant(correctArray))
}

//
//  CardsStackView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 03/03/2024.
//

import SwiftUI


struct CardsStackView: View {
    
    @Binding var viewModel: StudySessionViewModel
    
    var body: some View {
        ZStack {
            ForEach(0..<viewModel.studyCards.count, id: \.self) { index in
                StudySessionCard(card: viewModel.studyCards[index], color: index == (viewModel.studyCards.count - 1) ? Colors.setColor(using: viewModel.deck.folder!.colorName) : Color.gray, viewModel: $viewModel)
            }
        }
        .padding()
    }
}

//#Preview {
//    let correctArray = [CardModel(id: UUID(), question: "correct", answer: "correct")]
//    let wrongArray = [CardModel(id: UUID(), question: "wrong", answer: "wrong")]
//
//    return CardsStackView(deck: DeckModel(id: UUID(), name: "Test"), correctArray: .constant(correctArray), wrongArray: .constant(wrongArray), studyCards: .constant(correctArray))
//}

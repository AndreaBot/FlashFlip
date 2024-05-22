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
        VStack {
            ZStack {
                ForEach(0..<viewModel.studyCards.count, id: \.self) { index in
                    StudySessionCard(card: viewModel.studyCards[index], color: index == (viewModel.studyCards.count - 1) ? Colors.setColor(using: viewModel.deck.folder!.colorName) : Color.gray)
                }
            }
            if !viewModel.studyCards.isEmpty {
                MarkButtonsStack(card: $viewModel.studyCards[viewModel.studySessionIndex], viewModel: $viewModel)
            }
        }
        .padding()
    }
}


//#Preview {
//    @State var viewModel = StudySessionViewModel(deck: DeckModel(id: UUID(), name: "Test"))
//    var stack = viewModel.studyCards
//    stack.append(CardModel(id: UUID(), question: "1", answer: "1"))
//    viewModel.studyCards = stack
//     return CardsStackView(viewModel: $viewModel)    
//}


//
//  CardsStackView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 03/03/2024.
//

import SwiftUI


struct CardsStackView: View {
    
    @Binding var viewModel: StudySessionViewModel
    
    let scale = CGSize(width: 1, height: 1)
    let smallScale = CGSize(width: 0.8, height: 0.8)
    
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                ForEach(viewModel.studyCards.indices, id: \.self) { index in
                    StudySessionCard(card: viewModel.studyCards[index], color: Colors.setColor(using: viewModel.mark, folderColor: viewModel.deck.folder!.colorName))
                        .customSwipeAnimation(index: index, currentIndex: viewModel.studySessionIndex, scale: scale, smallScale: smallScale, edge: viewModel.mark == .correct ? .trailing : .leading)
                        .disabled(index != viewModel.studySessionIndex)
                }
            }
            Spacer()
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


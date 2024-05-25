//
//  EndView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 03/03/2024.
//

import SwiftUI

struct EndView: View {
    
    @Environment (\.dismiss) var dismiss
    
    @Binding var viewModel: StudySessionViewModel
    
    
    var body: some View {
        VStack {
            VStack {
                Text("END OF SESSION")
                    .font(.title).fontWeight(.semibold)
                
                Text("You scored \(viewModel.correctAnswers.count)/\(viewModel.correctAnswers.count + viewModel.wrongAnswers.count)")
                    .font(.title3)
            }
            
            if !viewModel.correctAnswers.isEmpty {
                VStack {
                    Text("Correct answers")
                    SmallCardsScrollView(cardsArray: viewModel.correctAnswers, deck: viewModel.deck)
                }
            }
            
            if !viewModel.wrongAnswers.isEmpty {
                VStack {
                    Text("Wrong answers")
                    SmallCardsScrollView(cardsArray: viewModel.wrongAnswers, deck: viewModel.deck)
                }
            }
            
            VStack {
                if !viewModel.practisingWeakCards {
                    Button("Start again") {
                        viewModel.startNewSession()
                    }
                    .buttonStyle(.borderedProminent)
                }
                
                Button("Go back") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(.vertical)
        .onAppear {
            viewModel.deck.sessionsCount += 1
            viewModel.calculateSessionCorrectAnswersPercentage()
            viewModel.calculateDeckAverageCorrectAnswers()
            viewModel.calculateCardScores()
        }
    }
}

//#Preview {
//    let correctArray = [CardModel(id: UUID(), question: "a", answer: "aa"),
//                        CardModel(id: UUID(), question: "b", answer: "bb")]
//    let wrongArray = [CardModel(id: UUID(), question: "1", answer: "11"),
//                      CardModel(id: UUID(), question: "2", answer: "22")]
//
//    @State var viewModel = StudySessionViewModel(deck: DeckModel(id: UUID(), name: "Test"))
//    return EndView(viewModel: $viewModel)
//}

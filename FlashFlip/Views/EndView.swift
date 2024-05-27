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
            Text("END OF SESSION")
                .font(.title).fontWeight(.semibold)
            
            Text("You scored \(viewModel.correctAnswers.count)/\(viewModel.correctAnswers.count + viewModel.wrongAnswers.count)")
                .font(.title3)
            
            List {
                if !viewModel.correctAnswers.isEmpty {
                    VStack {
                        Text("Correct answers")
                        SmallCardsScrollView(cardsArray: viewModel.correctAnswers, deck: viewModel.deck)
                    }
                    .frame(height: 230)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .padding(.top)
                }
                
                if !viewModel.wrongAnswers.isEmpty {
                    VStack {
                        Text("Wrong answers")
                        SmallCardsScrollView(cardsArray: viewModel.wrongAnswers, deck: viewModel.deck)
                    }
                    .frame(height: 230)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .padding(.top)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            
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
        .onAppear {
            viewModel.deck.sessionsCount += 1
            viewModel.calculateSessionCorrectAnswersPercentage()
            viewModel.calculateDeckAverageCorrectAnswers()
            viewModel.calculateCardScores()
        }
    }
}

//#Preview {
//    @State var viewModel = StudySessionViewModel(deck: DeckModel(id: UUID(), name: "Test"))
//    return EndView(viewModel: $viewModel)
//}

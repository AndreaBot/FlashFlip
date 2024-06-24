//
//  StudySessionView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 02/03/2024.
//

import SwiftUI

struct StudySessionView: View {
    
    @State var viewModel: StudySessionViewModel
    @State private var showingEmpty = false
    @State private var animateSymbol = false
    
    var body: some View {
        ZStack {
            if showingEmpty {
                ContentUnavailableView("Yahoo!", systemImage: "party.popper.fill", description: Text("You have no weak cards to practice!\nCards you have answered incorrectly 50% or more of the time will automatically appear here."))
                    .symbolEffect(.bounce, value: animateSymbol)
            } else {
                if !viewModel.studyCards.isEmpty {
                    CardsStackView(viewModel: $viewModel)
                } else {
                    EndView(viewModel: $viewModel)
                }
            }
        }
        .onAppear {
            viewModel.startNewSession()
            if viewModel.studyCards.isEmpty {
                showingEmpty = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    animateSymbol = true
                }
                
            }
        }
        .navigationTitle("Study Session")
    }
}

//#Preview {
//    let viewModel = StudySessionViewModel(deck: DeckModel(id: UUID(), name: "Test"))
//    return StudySessionView(viewModel: viewModel)
//}

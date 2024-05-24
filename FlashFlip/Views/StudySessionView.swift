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
    
    var body: some View {
        NavigationStack {
            ZStack {
                if showingEmpty {
                    ContentUnavailableView("Yahoo!", systemImage: "party.popper.fill", description: Text("You have no weak cards to practice!\nCards you have answered incorrectly 50% or more of the time will automatically appear here."))
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
                }
            }
            .navigationTitle("Study Session")
        }
    }
}

//#Preview {
//    let viewModel = StudySessionViewModel(deck: DeckModel(id: UUID(), name: "Test"))
//    return StudySessionView(viewModel: viewModel)
//}

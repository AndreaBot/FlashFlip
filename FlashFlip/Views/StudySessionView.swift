//
//  StudySessionView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 02/03/2024.
//

import SwiftUI

struct StudySessionView: View {
    
    @State var viewModel: StudySessionViewModel
    
    
    var body: some View {
        NavigationStack {
            if !viewModel.studyCards.isEmpty {
                CardsStackView(viewModel: $viewModel)
            } else {
                EndView(viewModel: $viewModel)
            }
        }
        .onAppear {
            viewModel.startNewSession()
        }
        .navigationTitle("Study Session")
    }
}

//#Preview {
//    StudySessionView()
//}

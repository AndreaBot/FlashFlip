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
    
    
    var body: some View {
        NavigationStack {
            GeometryReader { metrics in
                VStack {
                    ZStack {
                        ForEach(0..<studyCards.count, id: \.self) { index in
                            StudySessionCard(
                                card: deck.cards[index],
                                color: index == (studyCards.count - 1) ? Colors.setColor(using: deck.folder!.colorName) : Color.gray, array: $studyCards
                            )
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Study Session")
        }
        .onAppear {
            studyCards = deck.cards
        }
    }
}

#Preview {
    StudySessionView(deck: DeckModel(id: UUID(), name: "Test"))
}

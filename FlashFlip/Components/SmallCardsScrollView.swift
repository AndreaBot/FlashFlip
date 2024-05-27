//
//  SmallCardsScrollView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 25/05/2024.
//

import SwiftUI

struct SmallCardsScrollView: View {
    let cardsArray: [CardModel]
    let deck: DeckModel
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(cardsArray) { card in
                    CardViewComponent(card: card, deck: deck)
                        .padding([.leading, .bottom], 10)
                }
            }
            .scrollIndicators(.visible, axes: .horizontal)
        }
    }
}

//#Preview {
//    var deck = DeckModel(id: UUID(), name: "Test")
//    return SmallCardsScrollView(deck: deck)
//        .onAppear(perform: {
//            for i in 0...5 {
//                deck.cards.append(CardModel(id: UUID(), question: "\(i)", answer: "(\(i)"))
//            }
//        })
//}

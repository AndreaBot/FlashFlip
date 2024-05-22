//
//  CardStatsViewComponent.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 22/05/2024.
//

import SwiftUI

struct CardStatsViewComponent: View {
    
    let card: CardModel
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "checkmark")
                    .symbolVariant(.circle)
                    .foregroundStyle(.green)
                Text("x \(card.correctAnswersCount)")
            }
            Text(" - ")
            HStack {
                Image(systemName: "xmark")
                    .symbolVariant(.circle)
                    .foregroundStyle(.red)
                Text("x \(card.wrongAnswersCount)")
            }
        }
        .font(.title2)
        .fontDesign(.rounded)
        .fontWeight(.semibold)
    }
}

#Preview {
    CardStatsViewComponent(card: CardModel(id: UUID(), question: "test1", answer: "test2"))
}

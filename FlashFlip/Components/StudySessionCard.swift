//
//  StudySessionCardComponent.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 02/03/2024.
//

import SwiftUI

struct StudySessionCard: View {
    
    let card: CardModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .onTapGesture {
                card.rotationAmount += 180
                card.showingAnswer.toggle()
            }
            .overlay {
                Text(card.showingAnswer ? card.answer : card.question)
                    .foregroundStyle(.background)
                    .font(.title).fontWeight(.medium)
                    .rotation3DEffect(
                        .degrees(-card.rotationAmount), axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
            }
            .rotation3DEffect(
                .degrees(card.rotationAmount), axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .animation(.smooth(extraBounce: 0.3), value: card.rotationAmount)
            .containerRelativeFrame([.horizontal, .vertical]) { size, axis in
                size * 0.7
            }
    }
}

//#Preview {
//    return StudySessionCard(card: CardModel(question: "1", answer: "1"), color: .blue)
//}

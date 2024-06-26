//
//  StudySessionCardComponent.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 02/03/2024.
//

import SwiftUI

struct StudySessionCard: View {
    
    let card: CardModel
    let color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(color)
            .strokeBorder(.secondary, lineWidth: 10)
            .onTapGesture {
                card.rotationAmount += 180
                card.showingAnswer.toggle()
            }
            .overlay {
                Text(card.showingAnswer ? card.answer : card.question)
                    .font(.title).fontWeight(.medium)
                    .rotation3DEffect(
                        .degrees(-card.rotationAmount), axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
                    .padding()
                    .minimumScaleFactor(0.2)
                    .allowsHitTesting(false)
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
//    return StudySessionCard(card: CardModel(question: "A", answer: "B"))
//}

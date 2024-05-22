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
            .foregroundStyle(color)
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
            }
            .rotation3DEffect(
                .degrees(card.rotationAmount), axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .rotation3DEffect(
                .degrees(card.swipeAmount), axis: (x: 0.0, y: 1.0, z: 0.0), anchor: .trailing)
        
            .animation(.smooth(extraBounce: 0.3), value: card.rotationAmount)
            .animation(.linear(duration: 0.6), value: card.swipeAmount)
    }
}

#Preview {
    return StudySessionCard(card: CardModel(id: UUID(), question: "1", answer: "1"), color: .blue)
}

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
    @State private var showingAnswer = false
    @State private var rotationAmount = 0.0
    @State private var swipeAmount = 0.0
    
    @Binding var array: [CardModel]
    
    
    var body: some View {
        VStack {
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(color)
                .onTapGesture {
                    rotationAmount += 180
                    showingAnswer.toggle()
                }
                .overlay {
                    Text(showingAnswer ? card.answer : card.question)
                        .font(.title).fontWeight(.medium)
                        .rotation3DEffect(
                            .degrees(-rotationAmount), axis: (x: 0.0, y: 1.0, z: 0.0)
                        )
                }
                .rotation3DEffect(
                    .degrees(rotationAmount), axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .rotation3DEffect(
                    .degrees(swipeAmount), axis: (x: 0.0, y: 1.0, z: 0.0), anchor: .trailing)
                
            
                .animation(.smooth(extraBounce: 0.3), value: rotationAmount)
                .animation(.linear(duration: 0.6), value: swipeAmount)
              
            
            
            HStack {
                Spacer()
                
                Button {
                    progressGame()
                } label: {
                    Image(systemName: "checkmark")
                        .font(.largeTitle).fontWeight(.bold)
                }
                .padding()
                .foregroundStyle(.background)
                .background(.green)
                .clipShape(Circle())
                
                
                Spacer()
                
                Button {
                    progressGame()
                } label: {
                    Image(systemName: "multiply")
                        .font(.largeTitle).fontWeight(.bold)
                }
                
                .padding()
                .foregroundStyle(.background)
                .background(.red)
                .clipShape(Circle())
                
                Spacer()
            }
            .padding(.vertical)
        }
    }
    
    func progressGame() {
        swipeAmount += 180
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            array.removeLast()
        }
    }
}

#Preview {
    StudySessionCard(card: CardModel(id: UUID(), question: "4x4?", answer: "16"), color: .yellow, array: .constant([CardModel]()))
}

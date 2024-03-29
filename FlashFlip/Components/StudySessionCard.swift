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
    
    @Binding var correctGuesses: [CardModel]
    @Binding var wrongGuesses: [CardModel]
    
    
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
                    correctGuesses.append(array.last!)
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
                    wrongGuesses.append(array.last!)
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
    let correctArray = [CardModel(id: UUID(), question: "a", answer: "aa"),
                        CardModel(id: UUID(), question: "b", answer: "bb")]
    let wrongArray = [CardModel(id: UUID(), question: "1", answer: "11"),
                        CardModel(id: UUID(), question: "2", answer: "22")]
    
    return StudySessionCard(card: CardModel(id: UUID(), question: "4x4?", answer: "16"), color: .yellow, array: .constant([CardModel]()), correctGuesses: .constant(correctArray), wrongGuesses: .constant(wrongArray))
}

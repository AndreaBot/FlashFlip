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
    
    @Binding var viewModel: StudySessionViewModel
    
    
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
                    swipeAmount += 180
                    viewModel.progressGame(mark: "correct")
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
                    swipeAmount += 180
                    viewModel.progressGame(mark: "wrong")
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
}

#Preview {
    @State var viewModel = StudySessionViewModel(deck: DeckModel(id: UUID(), name: "11"))
    return StudySessionCard(card: CardModel(id: UUID(), question: "1", answer: "1"), color: .blue, viewModel: $viewModel)
}

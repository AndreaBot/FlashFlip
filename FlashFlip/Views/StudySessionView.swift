//
//  StudySessionView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 02/03/2024.
//

import SwiftUI

struct StudySessionView: View {
    
    let deck: DeckModel
    
    @State private var rotationAmount = 0.0
    @State private var showingAnswer = false
    @State private var currentIndex = 0
    
    var body: some View {
        NavigationStack {
            GeometryReader { metrics in
                VStack {
                    ZStack {
                        ForEach(0..<deck.cards.count, id: \.self) { card in
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(Colors.setColor(using: deck.folder!.colorName))
                                .onTapGesture {
                                    rotationAmount += 180
                                    showingAnswer.toggle()
                                }
                                .overlay {
                                    Text(showingAnswer ? deck.cards[currentIndex].answer : deck.cards[currentIndex].question)
                                        .font(.title).fontWeight(.medium)
                                        .rotation3DEffect(
                                            .degrees(-rotationAmount), axis: (x: 0.0, y: 1.0, z: 0.0)
                                        )
                                }
                                .rotation3DEffect(
                                    .degrees(rotationAmount), axis: (x: 0.0, y: 1.0, z: 0.0)
                                )
                        }
                        .animation(.smooth(extraBounce: 0.3), value: rotationAmount)
                    }
                    
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
                        .background(showingAnswer ? .green : .gray)
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
                        .background(showingAnswer ? .red : .gray)
                        .clipShape(Circle())
                        
                        Spacer()
                    }
                    .padding(.vertical)
                    .disabled(!showingAnswer)
                }
                .padding()
                .navigationTitle("Study Session")
            }
        }
    }
    
    func progressGame() {
        if currentIndex + 2 <= deck.cards.count {
            currentIndex += 1
            rotationAmount -= 180
            showingAnswer.toggle()
        }
    }
}

//#Preview {
//    StudySessionView()
//}

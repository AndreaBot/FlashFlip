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
                                color: index == (studyCards.count - 1) ? Colors.setColor(using: deck.folder!.colorName) : Color.gray
                            )
                        }
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
                    //.disabled(!showingAnswer)
                }
            }
            .padding()
            .navigationTitle("Study Session")
        }
        .onAppear {
            studyCards = deck.cards
        }
    }
    
    func progressGame() {
        //swipeAmount += 90
        rotationAmount -= 180
        studyCards.removeLast()
    }
}

//#Preview {
//    StudySessionView(deck: <#DeckModel#>)
//}

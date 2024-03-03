//
//  EndView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 03/03/2024.
//

import SwiftUI

struct EndView: View {
    
    let correctGuesses: Int
    let totalCards: Int
//    @Binding var correctArray: [CardModel]
//    @Binding var wrongArray: [CardModel]
    
    var correctArray: [CardModel]
    var wrongArray: [CardModel]
    
    var body: some View {
        VStack {
            
            Spacer()
            
            VStack {
                Text("END OF SESSION")
                    .font(.largeTitle).fontWeight(.bold)
                
                Text("You scored \(correctGuesses)/\(totalCards)")
                    .font(.title)
            }
            
            List {
                Section {
                    ForEach(correctArray) { card in
                        HStack {
                            Text("\(card.question)")
                            
                            Spacer()
                            Text("\(card.answer)")
                            
                        }
                        .padding()
                        .background(.green)
                        .clipShape(Capsule())
                    }
                    .listRowSeparator(.hidden)
                } header: {
                    Text("Correct answers")
                }
                
                Section {
                    ForEach(wrongArray) { card in
                        HStack {
                            Text("\(card.question)")
                            
                            Spacer()
                            Text("\(card.answer)")
                            
                        }
                        .padding()
                        .background(.red)
                        .clipShape(Capsule())
                    }
                    .listRowSeparator(.hidden)
                } header: {
                    Text("Wrong answers")
                }
            }
            .scrollContentBackground(.hidden)
           
            VStack(spacing: 20) {
                Button {
                    //correctArray.removeAll()
                    // wrongArray.removeAll()
                } label: {
                    Text("Start again")
                        .font(.title)
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                
              
                
                Button {
                    //dismiss()
                } label: {
                    Text("Go Back")
                        .font(.title)
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
            }
        }
        .padding(.vertical)
        }
}

#Preview {
    let correctArray = [CardModel(id: UUID(), question: "a", answer: "aa"),
                        CardModel(id: UUID(), question: "b", answer: "bb")]
    let wrongArray = [CardModel(id: UUID(), question: "1", answer: "11"),
                        CardModel(id: UUID(), question: "2", answer: "22")]
    
//    return EndView(correctGuesses: 5, totalCards: 10, correctArray: .constant(correctArray), wrongArray: .constant(wrongArray))
    
    return EndView(correctGuesses: 5, totalCards: 10, correctArray: correctArray, wrongArray: wrongArray)
}

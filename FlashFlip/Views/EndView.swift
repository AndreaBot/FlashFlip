//
//  EndView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 03/03/2024.
//

import SwiftUI

struct EndView: View {
    
    @Environment (\.dismiss) var dismiss
    
    @Binding var correctArray: [CardModel]
    @Binding var wrongArray: [CardModel]
    
    @Binding var studyDeck: [CardModel]
    
    var deck: DeckModel
    
    var body: some View {
        VStack {
            VStack {
                Text("END OF SESSION")
                    .font(.title).fontWeight(.semibold)
                
                Text("You scored \(correctArray.count)/\(correctArray.count + wrongArray.count)")
                    .font(.title3)
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
            .listStyle(PlainListStyle())
            
            VStack {
                Button {
                    correctArray.removeAll()
                    wrongArray.removeAll()
                    studyDeck.append(contentsOf: deck.cards.shuffled())
                } label: {
                    Text("Start again")
                        .font(.title2)
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                
                Button {
                    dismiss()
                } label: {
                    Text("Go Back")
                        .font(.title2)
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

//#Preview {
//    let correctArray = [CardModel(id: UUID(), question: "a", answer: "aa"),
//                        CardModel(id: UUID(), question: "b", answer: "bb")]
//    let wrongArray = [CardModel(id: UUID(), question: "1", answer: "11"),
//                      CardModel(id: UUID(), question: "2", answer: "22")]
//
//    return EndView(correctArray: correctArray, wrongArray: wrongArray)
//}

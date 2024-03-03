//
//  EndView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 03/03/2024.
//

import SwiftUI

struct EndView: View {
    
    var correctArray: [CardModel]
    var wrongArray: [CardModel]
    
    var body: some View {
        VStack {
            VStack {
                Text("END OF SESSION")
                    .font(.largeTitle).fontWeight(.bold)
                
                Text("You scored \(correctArray.count)/\(correctArray.count + wrongArray.count)")
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
            .listStyle(PlainListStyle())
            
            VStack {
                Button {
                    //correctArray.removeAll()
                    // wrongArray.removeAll()
                } label: {
                    Text("Start again")
                        .font(.title2)
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                
                Button {
                    //dismiss()
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

#Preview {
    let correctArray = [CardModel(id: UUID(), question: "a", answer: "aa"),
                        CardModel(id: UUID(), question: "b", answer: "bb")]
    let wrongArray = [CardModel(id: UUID(), question: "1", answer: "11"),
                      CardModel(id: UUID(), question: "2", answer: "22")]
    
    return EndView(correctArray: correctArray, wrongArray: wrongArray)
}

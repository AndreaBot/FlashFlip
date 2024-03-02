//
//  StudySessionView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 02/03/2024.
//

import SwiftUI

struct StudySessionView: View {
    
    //let deck: DeckModel
    
    @State private var rotationAmount = 0.0
    @State private var showingAnswer = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { metrics in
                VStack {
                    ZStack {
                        ForEach(0..<10, id: \.self) { card in
                        RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.yellow)
                                .onTapGesture {
                                    rotationAmount += 180
                                    showingAnswer.toggle()
                                }
                                .overlay {
                                    Text(showingAnswer ? "Test Answer" : "Test Question")
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
                            print("Good")
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
                            print("Bad")
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
                .padding()
                .navigationTitle("Study Session")
            }
        }
    }
}

#Preview {
    StudySessionView()
}

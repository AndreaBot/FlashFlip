//
//  DeckViewComponent.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 25/02/2024.
//

import SwiftUI
import SwiftData

struct DeckViewComponent: View {
    
    var context: ModelContext
    let deck: DeckModel
    
    var body: some View {
        ZStack {
            if !deck.cards.isEmpty {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 80)
                    .containerRelativeFrame(.horizontal) { size, axis in
                        size * 0.8
                    }
                    .foregroundStyle(Colors.setColor(using: deck.folder!.colorName)).opacity(0.55)
                    .offset(x: 0.0, y: 18.0)
                
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 80)
                    .containerRelativeFrame(.horizontal) { size, axis in
                        size * 0.85
                    }
                    .foregroundStyle(Colors.setColor(using: deck.folder!.colorName)).opacity(0.65)
                    .offset(x: 0.0, y: 14.0)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(deck.name)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    
                    Spacer()
                    
                    Text("Number of cards: \(deck.cards.count)")
                }
                .padding()
                
                Spacer()
            }
            .frame(height: 80)
            .padding(.vertical, 10)
            .containerRelativeFrame(.horizontal) { size, axis in
                size * 0.9
            }
            .background(Colors.setColor(using: deck.folder?.colorName ?? "blue"))
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: FolderModel.self, configurations: config)
    return DeckViewComponent(context: ModelContext(container), deck: DeckModel(name: "Test"))
}

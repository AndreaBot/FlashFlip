//
//  CardCollectionView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 24/02/2024.
//

import SwiftUI
import SwiftData

struct CardCollectionView: View {
    
    var context: ModelContext
    var deck: DeckModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(deck.cards) { card in
                    Text(card.question)
                }
            }
            
            .navigationTitle(deck.name)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        let newCard = CardModel(id: UUID(), question: "test", answer: "test")
                        
                        deck.cards.append(newCard)
                        
                        do {
                            try context.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                    } label: {
                        Image(systemName: "plus")
                            .fontWeight(.semibold)
                    }
                }
            }
        }
    }
}


//#Preview {
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: FolderModel.self, configurations: config)
//    
//    return CardCollectionView(context: ModelContext(container), deck: DeckModel(id: UUID(), name: "Test"))
//}

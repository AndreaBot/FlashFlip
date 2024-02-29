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
    
    @State private var cardQuestion = ""
    @State private var cardAnswer = ""
    @State private var showCardCreation = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { metrics in
                VStack {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(deck.cards) { card in
                                CardViewComponent(card: card, deck: deck)
                            }
                        }
                        .frame(height: metrics.size.height * 0.33)
                    }
                    
                    Spacer()
                    
                    NavigationLink("Browse Cards") {
                        CardsCarouselView(deck: deck, context: context)
                    }
                    
                    Spacer()
                }
                .navigationTitle(deck.name)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button {
                            showCardCreation = true
                        } label: {
                            Image(systemName: "plus")
                                .fontWeight(.semibold)
                        }
                    }
                }
                .sheet(isPresented: $showCardCreation) {
                    CardCreationView(deck: deck, context: context, cardQuestion: $cardQuestion, cardAnswer: $cardAnswer, showCardCreation: $showCardCreation, cardIsBeingModified: false)
                        .presentationDetents([.fraction(0.34)])
                }
            }
        }
    }
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: FolderModel.self, configurations: config)
    
    return CardCollectionView(context: ModelContext(container), deck: DeckModel(id: UUID(), name: "Test"))
}

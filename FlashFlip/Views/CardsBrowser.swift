//
//  CardsCarouselView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 28/02/2024.
//

import SwiftUI
import SwiftData


struct CardsBrowser: View {
    
    @Environment(\.dismiss) var dismiss
    @State var deck: DeckModel
    var context: ModelContext
    @State private var showCardCreation = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { metrics in
                if !deck.cards.isEmpty {
                    CardCarouselView(context: context, deck: $deck)
                } else {
                    ContentUnavailableView {
                        Label("Your deck is empty", systemImage: "square.3.layers.3d.slash")
                    } description: {
                        Text("Tap the + button to start adding cards to the deck")
                    } actions: {
                        Button {
                            showCardCreation = true
                        } label: {
                            Image(systemName: "plus")
                                .symbolVariant(.circle)
                                .font(.title)
                        }
                    }
                }
            }
            .navigationTitle("\(deck.name)")
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
                CardCreationView(deck: deck, context: context, cardIsBeingModified: false)
                    .presentationDetents([.fraction(0.34)])
            }
        }
    }
}


//#Preview {
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: FolderModel.self, configurations: config)
//    
//    return  CardsBrowser (deck: DeckModel(id: UUID(), name: "Test"), context: ModelContext(container))
//}

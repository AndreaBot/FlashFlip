//
//  CardCollectionView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 24/02/2024.
//

import SwiftUI
import SwiftData

struct CardCollectionView: View {
    
    @State var deck: DeckModel
    @State private var newDeckName = ""
    @State private var showCardCreation = false
    @State private var showDeckNameEditing = false
    
    var context: ModelContext
    
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
                    
                    Form {
                        NavigationLink("Browse Cards") {
                            CardsCarouselView(deck: deck, context: context)
                        }
                        .disabled(deck.cards.isEmpty ? true : false)
                        
                        NavigationLink("Start Study Session") {
                            StudySessionView(deck: deck)
                        }
                        .disabled(deck.cards.isEmpty)
                        
                    }
                }
                .navigationTitle(deck.name)
                .toolbar {
                    ToolbarItemGroup(placement: .confirmationAction) {
                        Button {
                            showDeckNameEditing = true
                        } label: {
                            Image(systemName: "pencil")
                                .fontWeight(.semibold)
                        }
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
                .alert("Edit Deck name", isPresented: $showDeckNameEditing) {
                    TextField("Type the new name", text: $newDeckName)
                        .foregroundStyle(.black)
                        .onSubmit {
                            updateDeckName()
                        }
                    Button("Cancel") {}
                    Button("Confirm") {
                        updateDeckName()
                    }
                }
                .onAppear {
                    newDeckName = deck.name
                }
            }
        }
    }
    
    func updateDeckName() {
        guard newDeckName != "" else {
            newDeckName = deck.name
            showDeckNameEditing = false
            return
        }
        deck.name = newDeckName
        showDeckNameEditing = false
    }
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: FolderModel.self, configurations: config)
    
    return CardCollectionView(deck: DeckModel(id: UUID(), name: "Test"), context: ModelContext(container))
}

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
    @State var deck: DeckModel
    @State private var newDeckName = ""
    
    @State private var cardQuestion = ""
    @State private var cardAnswer = ""
    @State private var showCardCreation = false
    @State private var showDeckNameEditing = false
    
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
                        .disabled(deck.cards.isEmpty ? true : false)
                        
                    }
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
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            showDeckNameEditing = true
                        } label: {
                            Image(systemName: "pencil")
                                .fontWeight(.semibold)
                        }
                    }
                }
                .sheet(isPresented: $showCardCreation) {
                    CardCreationView(deck: deck, context: context, cardQuestion: $cardQuestion, cardAnswer: $cardAnswer, showCardCreation: $showCardCreation, cardIsBeingModified: false)
                        .presentationDetents([.fraction(0.34)])
                }
                .alert("Edit Deck name", isPresented: $showDeckNameEditing) {
                    TextField("Type the new name", text: $newDeckName)
                        .onSubmit {
                            updateDeckName()
                        }
                    Button("Confirm") {
                        updateDeckName()
                    }
                    
                    Button("Cancel") {
                        showDeckNameEditing = false
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
    
    return CardCollectionView(context: ModelContext(container), deck: DeckModel(id: UUID(), name: "Test"))
}

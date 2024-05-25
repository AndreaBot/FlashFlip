//
//  CardCollectionView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 24/02/2024.
//

import SwiftUI
import SwiftData

struct DeckView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var deck: DeckModel
    @State private var newDeckName = ""
    @State private var showCardCreation = false
    @State private var showDeckNameEditing = false
    @State private var showingDeleteConfirmation = false
    
    var context: ModelContext
    
    var body: some View {
        GeometryReader { metrics in
            VStack {
                if !deck.cards.isEmpty {
                    SmallCardsScrollView(cardsArray: deck.cards.sorted(), deck: deck)
                        .containerRelativeFrame(.vertical) { size, axis in
                            size * 0.33
                        }
                    
                } else {
                    Text("Your deck is currently empty!")
                        .containerRelativeFrame(.vertical) { size, axis in
                            size * 0.33
                        }
                }
                
                Spacer()
                
                Form {
                    Section {
                        HStack {
                            Text("Number of sessions:")
                            Spacer()
                            Text("\(deck.sessionsCount)")
                        }
                        HStack {
                            Text("Average result:")
                            Spacer()
                            Text(deck.sessionsCount == 0 ? "/" : String(format: "%.2f", deck.averageCorrectAnswers)+"%")
                        }
                    }
                    
                    Section {
                        NavigationLink("Browse cards") {
                            CardsBrowser(deck: deck, context: context)
                        }
                        .disabled(deck.cards.isEmpty)
                        
                        Button {
                            showCardCreation = true
                        } label: {
                            Text("Create new cards")
                        }
                        .buttonStyle(.borderless)
                    }
                    
                    Section {
                        NavigationLink("Start study session") {
                            StudySessionView(viewModel: StudySessionViewModel(deck: deck, studyCards: deck.cards.shuffled(), practisingWeakCards: false))
                        }
                        .disabled(deck.cards.isEmpty)
                        
                        NavigationLink("Practice weak cards") {
                            StudySessionView(viewModel: StudySessionViewModel(deck: deck, studyCards: StudySessionViewModel.createWeakCardsSession(deck: deck), practisingWeakCards: true))
                        }
                        .disabled(deck.cards.isEmpty)
                    }
                }
            }
            .navigationTitle(deck.name)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Menu {
                        Button {
                            showDeckNameEditing = true
                        } label: {
                            Label("Edit deck name", systemImage: "pencil")
                        }
                        
                        Button {
                            showCardCreation = true
                        } label: {
                            Label("Add cards", systemImage: "plus")
                        }
                        
                        Button(role: .destructive) {
                            showingDeleteConfirmation = true
                        } label: {
                            Label("Delete deck", systemImage: "trash")
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .fontWeight(.semibold)
                    }
                    
                }
            }
            .sheet(isPresented: $showCardCreation) {
                CardCreationView(deck: deck, context: context, cardIsBeingModified: false)
                    .presentationDetents([.fraction(0.34)])
            }
            .alert("Attention", isPresented: $showingDeleteConfirmation, actions: {
                Button("Delete", role: .destructive) {
                    DataManager.deleteDeck(context, deck)
                    dismiss()
                }
            }, message: {
                Text("Do you wish to delete this folder and all of its cards?")
            })
            .alert("Edit Deck name", isPresented: $showDeckNameEditing) {
                TextField("Type the new name", text: $newDeckName)
                    .foregroundStyle(.black)
                    .onSubmit {
                        if newDeckName.isEmpty {
                            return
                        }
                        deck.name = newDeckName
                        showDeckNameEditing = false
                    }
                Button("Cancel") {}
                Button("Confirm") {
                    deck.name = newDeckName
                }
                .disabled(newDeckName.isEmpty)
            }
            .onChange(of: showDeckNameEditing) { _, _ in
                newDeckName = deck.name
            }
        }
    }
}


//#Preview {
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: FolderModel.self, configurations: config)
//
//    return DeckView(deck: DeckModel(name: "test"), context: ModelContext(container))
//}


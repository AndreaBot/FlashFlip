//
//  CreateDeckView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 24/02/2024.
//

import SwiftUI
import SwiftData

struct DeckListView: View {
    
    @State private var deckName = ""
    @State private var showingDeckCreation = false
    @State private var showFolderEditing = false
    
    var context: ModelContext
    var folder: FolderModel
    var columns = [GridItem(.adaptive(minimum: UIScreen.main.bounds.width/3))]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(folder.decks) { deck in
                    NavigationLink {
                        CardCollectionView(deck: deck, context: context)
                    } label: {
                        DeckViewComponent(context: context, deck: deck)
                    }
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        deleteDeck(folder.decks[index])
                    }
                })
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                
                Button {
                    showingDeckCreation = true
                } label: {
                    CreateElementComponent(height: 95)
                }
                .buttonStyle(.plain)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
            .navigationTitle(folder.name)
            .toolbar {
                ToolbarItemGroup(placement: .confirmationAction) {
                    Button {
                        showFolderEditing = true
                    } label: {
                        Image(systemName: "pencil")
                            .fontWeight(.semibold)
                    }
                    Button {
                        showingDeckCreation = true
                    } label: {
                        Image(systemName: "plus")
                            .fontWeight(.semibold)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Image(systemName: folder.iconName)
                        .foregroundStyle(Colors.setColor(using: folder.colorName))
                        .fontWeight(.semibold)
                }
            }
            .alert("Create New Deck", isPresented: $showingDeckCreation) {
                TextField("New Deck Name", text: $deckName)
                    .onSubmit {
                        guard !deckName.isEmpty else {
                            return
                        }
                        createNewDeck()
                    }
                Button("Cancel") {
                    deckName = ""
                }
                Button("Confirm") {
                    createNewDeck()
                }
                .disabled(deckName.isEmpty)
            }
            .sheet(isPresented: $showFolderEditing) {
                CreateFolderView(context: context, folder: folder, folderIsBeingModified: true)
            }
        }
    }
    
    func createNewDeck() {
        folder.decks.append(DeckModel(id: UUID(), name: deckName, folder: folder))
        do {
            try context.save()
            deckName = ""
        } catch {
            print(error.localizedDescription)
        }
        showingDeckCreation = false
    }
    
    func deleteDeck(_ deck: DeckModel) {
        context.delete(deck)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: FolderModel.self, configurations: config)
    
    return DeckListView(context: ModelContext(container), folder: FolderModel(id: UUID(), name: "Test", iconName: "brain", colorName: "blue"))
}

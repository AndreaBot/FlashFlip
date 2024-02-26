//
//  CreateDeckView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 24/02/2024.
//

import SwiftUI
import SwiftData

struct DeckListView: View {
    
    var context: ModelContext
    var folder: FolderModel
    
    @State private var deckName = ""
    @State private var showingPopUp = false
    
    var columns = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width/3))
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(folder.decks) { deck in
                    NavigationLink {
                        CardCollectionView(context: context, deck: deck)
                    } label: {
                        DeckViewComponent(context: context, deck: deck)
                    }
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                
                Button {
                    showingPopUp = true
                } label: {
                    CreateElementComponent(height: 95)
                }
                .buttonStyle(.plain)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
            .navigationTitle(folder.name)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        showingPopUp = true
                    } label: {
                        Image(systemName: "plus")
                            .fontWeight(.semibold)
                    }
                }
            }
            .alert("Create New Deck", isPresented: $showingPopUp) {
                TextField("New Deck name", text: $deckName)
                    .onSubmit {
                        createNewDeck()
                    }
                Button("Confirm") {
                        createNewDeck()
                }
                .disabled(deckName != "" ? false : true)
                
                Button("Cancel") {
                    showingPopUp = false
                }
            }
        }
    }
    
    func createNewDeck() {
        guard deckName != "" else { return }
        
        let newDeck = DeckModel(id: UUID(), name: deckName, folder: folder)
        folder.decks.append(newDeck)
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        deckName = ""
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: FolderModel.self, configurations: config)
    
    return DeckListView(context: ModelContext(container), folder: FolderModel(id: UUID(), name: "Test", iconName: "plus", colorName: "blue"))
}

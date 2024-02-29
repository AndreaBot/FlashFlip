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
    @State var folder: FolderModel
    
    @State private var deckName = ""
    @State private var showingPopUp = false
    @State private var showFolderEditing = false
    
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
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        deleteDeck(folder.decks[index])
                    }
                })
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
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showFolderEditing = true
                    } label: {
                        Image(systemName: "pencil")
                            .fontWeight(.semibold)
                    }
                }
            }
            .alert("Create New Deck", isPresented: $showingPopUp) {
                TextField("New Deck Name", text: $deckName)
                    .onSubmit {
                        createNewDeck()
                    }
                
                Button("Confirm") {
                    createNewDeck()
                }
                  
                Button("Cancel") {
                    showingPopUp = false
                    deckName = ""
                }
            }
            .sheet(isPresented: $showFolderEditing) {
                CreateFolderView(context: context, folderName: $folder.name, folderIconName: $folder.iconName, folderColorName: $folder.colorName, folderIsBeingModified: true)
            }
        }
    }
    
    func createNewDeck() {
        guard !deckName.isEmpty else {
            showingPopUp = false
            return
        }
        
        let newDeck = DeckModel(id: UUID(), name: deckName, folder: folder)
        folder.decks.append(newDeck)
        
        do {
            try context.save()
            deckName = ""
        } catch {
            print(error.localizedDescription)
        }
        showingPopUp = false
    }
    
    func deleteDeck(_ deck: DeckModel) {
        context.delete(deck)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: FolderModel.self, configurations: config)
    
    return DeckListView(context: ModelContext(container), folder: FolderModel(id: UUID(), name: "Test", iconName: "plus", colorName: "blue"))
}

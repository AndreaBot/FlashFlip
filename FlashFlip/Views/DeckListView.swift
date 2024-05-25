//
//  CreateDeckView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 24/02/2024.
//

import SwiftUI
import SwiftData

struct DeckListView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var deckName = ""
    @State private var showingDeckCreation = false
    @State private var showFolderEditing = false
    @State private var showingDeleteConfirmation = false
    
    var context: ModelContext
    var folder: FolderModel
    var columns = [GridItem(.adaptive(minimum: UIScreen.main.bounds.width/3))]
    
    var body: some View {
        VStack {
            if !folder.decks.isEmpty {
                List {
                    ForEach(folder.decks.sorted()) { deck in
                        NavigationLink {
                            DeckView(deck: deck, context: context)
                        } label: {
                            DeckViewComponent(context: context, deck: deck)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        for index in indexSet {
                            DataManager.deleteDeck(context, folder.decks[index])
                        }
                    })
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
            } else {
                ContentUnavailableView {
                    Label("Your folder is empty", systemImage: "tray")
                } description: {
                    Text("Tap the + button to create a new deck")
                }
            }
            Button {
                showingDeckCreation = true
            } label: {
                CreateElementComponent()
            }
            .buttonStyle(.plain)
        }
        .navigationTitle(folder.name)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Menu {
                    Button {
                        showFolderEditing = true
                    } label: {
                        Label("Edit folder", systemImage: "pencil")
                    }
                    
                    Button {
                        showingDeckCreation = true
                    } label: {
                        Label("Create new deck", systemImage: "plus")
                    }
                    
                    Button(role: .destructive) {
                        showingDeleteConfirmation = true
                    } label: {
                        Label("Delete folder", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .fontWeight(.semibold)
                }
            }
            ToolbarItem(placement: .principal) {
                Image(systemName: folder.iconName)
                    .foregroundStyle(Colors.setColor(using: folder.colorName))
                    .fontWeight(.semibold)
            }
        }
        .alert("Attention", isPresented: $showingDeleteConfirmation, actions: {
            Button("Delete", role: .destructive) {
                DataManager.deleteFolder(context, folder)
                dismiss()
            }
        }, message: {
            Text("Do you wish to delete this folder and all of its content?")
        })
        .alert("Create New Deck", isPresented: $showingDeckCreation) {
            TextField("New Deck Name", text: $deckName)
                .onSubmit {
                    guard !deckName.isEmpty else {
                        return
                    }
                    DataManager.createNewDeck(context, folder: folder, deckName)
                    deckName = ""
                }
            Button("Cancel") {
                deckName = ""
            }
            Button("Confirm") {
                DataManager.createNewDeck(context, folder: folder, deckName)
                deckName = ""
            }
            .disabled(deckName.isEmpty)
        }
        .sheet(isPresented: $showFolderEditing) {
            CreateFolderView(context: context, folder: folder, folderIsBeingModified: true)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: FolderModel.self, configurations: config)
    
    return DeckListView(context: ModelContext(container), folder: FolderModel(name: "Test", iconName: "brain", colorName: "blue"))
}

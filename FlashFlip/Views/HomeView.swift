//
//  ContentView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 24/02/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @Environment(\.modelContext) private var context
    @Query var allFolders: [FolderModel]
    
    @State private var showingNewFolderView = false
    @State private var showFolderEditing = false
    @State private var folderName = ""
    @State private var folderIconName: String?
    @State private var folderColorname = ""
    
    @State private var mockFolder = FolderModel(id: UUID(), name: "", iconName: "", colorName: "")
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(allFolders) { folder in
                    NavigationLink {
                        DeckListView(context: context, folder: folder)
                    } label: {
                        FolderViewComponent(context: context, folder: folder)
                    }
                    .swipeActions{
                        Button(role: .destructive) {
                            deleteFolder(folder)
                        } label: {
                            Image(systemName: "trash")
                        }
                        
                        Button() {
                            if let selectedIndex = allFolders.firstIndex(where: { selectedFolder in
                                selectedFolder == folder
                            }) {
                                mockFolder = allFolders[selectedIndex]
                                showFolderEditing = true
                            }
                        } label: {
                            Image(systemName: "pencil")
                        }
                        .tint(.blue)
                    }
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                
                Button {
                    showingNewFolderView = true
                } label: {
                    CreateElementComponent(height: 150)
                }
                .buttonStyle(.plain)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                
            }
            .navigationTitle("Flash Flip")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingNewFolderView = true
                    } label: {
                        Image(systemName: "plus")
                            .fontWeight(.semibold)
                    }
                }
            }
        }
        .sheet(isPresented: $showingNewFolderView, content: {
            CreateFolderView(context: context, folderName: $folderName, folderIconName: $folderIconName, folderColorName: $folderColorname, folderIsBeingModified: false)
        })
        .sheet(isPresented: $showFolderEditing) {
            CreateFolderView(context: context, folderName: $mockFolder.name, folderIconName: $mockFolder.iconName, folderColorName: $mockFolder.colorName, folderIsBeingModified: true)
        }
    }
    
    func deleteFolder(_ folder: FolderModel) {
        context.delete(folder)
    }
    
}

#Preview {
    HomeView()
}

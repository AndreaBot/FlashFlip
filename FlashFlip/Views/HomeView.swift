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
    @Query(sort: \FolderModel.id) var allFolders: [FolderModel]
    
    @State private var showingCreateFolderView = false
    @State private var selectedFolder: FolderModel?
    
    
    var body: some View {
        NavigationStack {
            VStack {
                if !allFolders.isEmpty {
                    List {
                        ForEach(allFolders) { folder in
                            NavigationLink {
                                DeckListView(context: context, folder: folder)
                            } label: {
                                FolderViewComponent(context: context, folder: folder)
                            }
                            .swipeActions{
                                Button(role: .destructive) {
                                    DataManager.deleteFolder(context, folder)
                                } label: {
                                    Image(systemName: "trash")
                                }
                                
                                Button {
                                    selectedFolder = folder
                                } label: {
                                    Image(systemName: "pencil")
                                }
                                .tint(.blue)
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                } else {
                    ContentUnavailableView {
                        Label("Nothing to se here...yet.", systemImage: "questionmark.folder")
                    } description: {
                        Text("Tap the + button to create a new folder")
                    }
                }
                
                Button {
                    showingCreateFolderView = true
                } label: {
                    CreateElementComponent()
                }
                .buttonStyle(.plain)
            }
            .navigationTitle("Flash Flip")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingCreateFolderView = true
                    } label: {
                        Image(systemName: "plus")
                            .fontWeight(.semibold)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showingCreateFolderView){
            CreateFolderView(context: context, folderIsBeingModified: false)
        }
        .fullScreenCover(item: $selectedFolder) { selectedFolder in
            CreateFolderView(context: context, folder: selectedFolder, folderIsBeingModified: true)
        }
    }
}

#Preview {
    HomeView()
}

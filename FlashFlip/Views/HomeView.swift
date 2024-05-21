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
    
    @State private var showingCreateFolderView = false
    @State private var selectedFolder: FolderModel?
    
    
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
                
                Button {
                    showingCreateFolderView = true
                } label: {
                    CreateElementComponent(height: 150, text: "Create new folder")
                }
                .buttonStyle(.plain)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                
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

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
    @State private var showingFolderDeleteConfirmation = false
    @State private var showingDatabaseClearingConfimration = false
    @State private var selectedFolder: FolderModel?
    @State private var swipedFolder: FolderModel?
    
    @State private var showingWelcomeMessage = false
    
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
                                Button {
                                    swipedFolder = folder
                                    showingFolderDeleteConfirmation = true
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .tint(.red)
                                
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
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showingDatabaseClearingConfimration = true
                    } label: {
                        Image(systemName: "square.3.layers.3d.down.right.slash")
                            .fontWeight(.semibold)
                    }
                    .disabled(allFolders.isEmpty)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingCreateFolderView = true
                    } label: {
                        Image(systemName: "plus")
                            .fontWeight(.semibold)
                    }
                }
            }
            .alert("Attention", isPresented: $showingFolderDeleteConfirmation) {
                Button("Delete", role: .destructive) {
                    DataManager.deleteFolder(context, swipedFolder!)
                }
            } message: {
                Text("Do you wish to delete this folder and all of its content?")
            }
            .alert("Attention", isPresented: $showingDatabaseClearingConfimration) {
                Button("Delete", role: .destructive) {
                    DataManager.clearDatabase(context: context, allFolders: allFolders)
                }
            } message: {
                Text("Are you sure you want to clear all data? This action cannot be undone!")
            }
        }
        .fullScreenCover(isPresented: $showingCreateFolderView){
            CreateFolderView(context: context, folderIsBeingModified: false)
        }
        .fullScreenCover(item: $selectedFolder) { selectedFolder in
            CreateFolderView(context: context, folder: selectedFolder, folderIsBeingModified: true)
        }
        .onAppear {
            //THIS IS JUST A QUICK WAY TO LET RECRUITERS SEE SOME EXAMPLE DATA AS THEY LAUNCH THE APP
            if !allFolders.contains(where: { folderModel in
                folderModel.name == "Geography"
            }) {
                SampleData.createSampleFolder(context)
                
            }
            showingWelcomeMessage = true
        }
        .alert("Welcome 👋🏻", isPresented: $showingWelcomeMessage) {
        } message: {
            Text(SampleData.welcomeMessage)
        }
    }
}

#Preview {
    HomeView()
}

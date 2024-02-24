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
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(allFolders) { folder in
                    NavigationLink {
                        DeckListView(context: context, folder: folder)
                    } label: {
                        FolderViewComponent(context: context, folder: folder)
                    }
                    
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        deleteFolder(allFolders[index])
                    }
                })
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
            CreateFolderView(context: context)
        })
    }
    
    func deleteFolder(_ folder: FolderModel) {
        context.delete(folder)
    }
    
}

#Preview {
    HomeView()
}

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
                    FolderViewComponent(folder: folder)
                }
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
}

#Preview {
    HomeView()
}

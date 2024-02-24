//
//  ContentView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 24/02/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var allFolders = [FolderModel]()
    
    @State private var showingNewFolderView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(allFolders) { folder in
                    FolderViewComponent(folder: folder)
                }
            }
            .padding()
            .navigationTitle("Flash Flip")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingNewFolderView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showingNewFolderView, content: {
            CreateFolderView(allFolders: allFolders)
        })
    }
}

#Preview {
    ContentView()
}

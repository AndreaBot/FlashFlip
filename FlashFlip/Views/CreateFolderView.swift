//
//  CreateFolderView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 24/02/2024.
//

import SwiftUI

struct CreateFolderView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var allFolders: [FolderModel]
    
    var columns = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width/6))
    ]
    
    @State private var folderName = ""
    @State private var folderIconName = ""
    @State private var folderColorName = ""
    @FocusState private var txtFieldFocused: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Type the folder name", text: $folderName)
                        .focused($txtFieldFocused)
                        .padding(.vertical, 8)
                }
                
                Section("Select an icon") {
                    LazyVGrid(columns: columns) {
                        ForEach(Icons.allIcons, id: \.self) { icon in
                            IconsGridItemView(iconName: icon, isSelected: icon == folderIconName)
                                .onTapGesture {
                                    folderIconName = icon
                                }
                        }
                    }
                }
                
                Section("Select a color") {
                    LazyVGrid(columns: columns) {
                        ForEach(Colors.allColors, id: \.self) { color in
                            ColorsGridItemViewComponent(iconColor: color, isSelected: color == folderColorName)
                                .onTapGesture {
                                    folderColorName = color
                                }
                        }
                    }
                }
            }
            .navigationTitle("Create New Folder")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        let newFolder = FolderModel(id: UUID(), name: folderName, iconName: folderIconName, colorName: folderColorName)
                        allFolders.append(newFolder)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    CreateFolderView(allFolders: [FolderModel(id: UUID(), name: "A", iconName: "swift", colorName: "yellow"),
                                 FolderModel(id: UUID(), name: "B", iconName: "plus", colorName: "blue")]
    )
}


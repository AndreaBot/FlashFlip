//
//  CreateFolderView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 24/02/2024.
//

import SwiftUI
import SwiftData

struct CreateFolderView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var newFolderName = ""
    @State private var newFolderIconName = "folder"
    @State private var newFolderColorName = ""
    
    @FocusState private var txtFieldFocused: Bool
    
    var context: ModelContext
    var folder: FolderModel?
    let folderIsBeingModified: Bool
    var columns = [GridItem(.adaptive(minimum: UIScreen.main.bounds.width/6))]
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Type the folder name", text: $newFolderName)
                        .focused($txtFieldFocused)
                        .padding(.vertical, 8)
                }
                
                Section("Select a color") {
                    LazyVGrid(columns: columns) {
                        ForEach(Colors.allColors, id: \.self) { color in
                            ColorsGridItemViewComponent(iconColor: color, isSelected: color == newFolderColorName)
                                .onTapGesture {
                                    newFolderColorName = color
                                }
                        }
                    }
                }
                
                Section("Select an icon") {
                    LazyVGrid(columns: columns) {
                        ForEach(Icons.allIcons.sorted(), id: \.self) { icon in
                            IconsGridItemView(iconName: icon, isSelected: icon == newFolderIconName)
                                .onTapGesture {
                                    newFolderIconName = icon
                                }
                        }
                    }
                }
            }
            .navigationTitle(folderIsBeingModified ? "Edit Folder" : "Create New Folder")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        folderIsBeingModified ? DataManager.confirmChanges(folder, newFolderName, newFolderIconName, newFolderColorName) : DataManager.createFolder(context, newFolderName, newFolderIconName, newFolderColorName)
                        dismiss()
                    }
                    .disabled(newFolderName.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                if folderIsBeingModified {
                    showCurrentFolderDetails()
                }
            }
        }
    }
    
    func showCurrentFolderDetails() {
        if let folder = folder {
            newFolderName = folder.name
            newFolderIconName = folder.iconName
            newFolderColorName = folder.colorName
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: FolderModel.self, configurations: config)
    return CreateFolderView(context: ModelContext(container), folderIsBeingModified: false)
}


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
    
    var context: ModelContext
    
    var columns = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width/6))
    ]
    
    @Binding  var folderName: String
    @Binding  var folderIconName: String?
    @Binding  var folderColorName: String
    @FocusState private var txtFieldFocused: Bool
    
    let folderIsBeingModified: Bool
    @State private var originalFolderName = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Type the folder name", text: $folderName )
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
            .navigationTitle(folderIsBeingModified ? "Edit Folder" : "Create New Folder")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        folderIsBeingModified ? dismiss() : createFolder()
                    }
                    .disabled(folderName.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        folderName = originalFolderName
                        dismiss()
                    }
                }
            }
            .onAppear {
                if folderIsBeingModified {
                    originalFolderName = folderName
                }
            }
        }
    }
    
    func createFolder() {
        let newFolder = FolderModel(id: UUID(), name: folderName, iconName: folderIconName ?? "folder", colorName: folderColorName)
        context.insert(newFolder)
        folderName = ""
        folderIconName = ""
        folderColorName = ""
        dismiss()
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: FolderModel.self, configurations: config)
    
    return CreateFolderView(context: ModelContext(container), folderName: .constant("Folder Name"), folderIconName: .constant("heart.fill"), folderColorName: .constant("red"), folderIsBeingModified: false)
}


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
    
    @State private var folderName = ""
    @State private var folderIconName: String?
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
                        let newFolder = FolderModel(id: UUID(), name: folderName, iconName: folderIconName ?? "folder", colorName: folderColorName)
                        context.insert(newFolder)
                        dismiss()
                    }
                    .disabled(folderName.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: FolderModel.self, configurations: config)
    
    return CreateFolderView(context: ModelContext(container))
}


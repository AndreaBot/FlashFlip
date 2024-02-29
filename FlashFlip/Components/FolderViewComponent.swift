//
//  FolderView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 24/02/2024.
//

import SwiftUI
import SwiftData

struct FolderViewComponent: View {
    
    var context: ModelContext
    let folder: FolderModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(folder.name)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                Spacer()
                
                Image(systemName: folder.iconName!)
                    .resizable()
                    .scaledToFit()
            }
            
            Spacer()
            
            Text("Number of decks: \(folder.decks.count)")
            
        }
        .padding()
        .frame(height: 150)
        .containerRelativeFrame(.horizontal) { size, axis in
            size * 0.9
        }
        .background(Colors.setColor(using: folder.colorName))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: FolderModel.self, configurations: config)
    
    return FolderViewComponent(context: ModelContext(container), folder: FolderModel(id: UUID(), name: "Swift", iconName: "swift", colorName: "orange"))
}

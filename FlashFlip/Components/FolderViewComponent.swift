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
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(Colors.setColor(using: folder.colorName))
            
            VStack(alignment: .leading) {
                HStack {
                    Text(folder.name)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        
                    Spacer()
                    
                    Image(systemName: folder.iconName)
                        .resizable()
                        .scaledToFit()
                }
                
                Spacer()
                
                Text("Number of decks: \(folder.decks.count)")
                
            }
            .padding()
        }
        .frame(width: 300, height: 150)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: FolderModel.self, configurations: config)
    
    return FolderViewComponent(context: ModelContext(container), folder: FolderModel(id: UUID(), name: "Swift", iconName: "swift", colorName: "orange"))
}

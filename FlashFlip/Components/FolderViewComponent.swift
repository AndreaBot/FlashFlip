//
//  FolderView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 24/02/2024.
//

import SwiftUI

struct FolderViewComponent: View {
    
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
   FolderViewComponent(folder: FolderModel(id: UUID(), name: "Swift", iconName: "swift", colorName: "orange"))
}

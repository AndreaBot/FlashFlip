//
//  DeckViewComponent.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 25/02/2024.
//

import SwiftUI
import SwiftData

struct DeckViewComponent: View {

    var context: ModelContext
    let deck: DeckModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(Colors.setColor(using: deck.folder.colorName))
                //.foregroundStyle(Color.red)
            
            VStack(alignment: .leading) {
              
                    Text(deck.name)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        

                Spacer()
                
            Text("Number of cards: \(deck.cards.count)")
                
            }
            .padding()
        }
        .frame(width: 300, height: 80)
        .padding(.vertical, 10)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: FolderModel.self, configurations: config)
    
    return DeckViewComponent(context: ModelContext(container), deck: DeckModel(id: UUID(), name: "test", folder: FolderModel(id: UUID(), name: "test", iconName: "swift", colorName: "green")))
}

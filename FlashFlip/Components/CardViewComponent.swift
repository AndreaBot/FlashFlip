//
//  CardViewComponent.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 24/02/2024.
//

import SwiftUI
import SwiftData

struct CardViewComponent: View {
    
    let card: CardModel
    let deck: DeckModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 15)
                .fill(Colors.setColor(using: deck.folder!.colorName))
                .strokeBorder(.secondary, lineWidth: 6)
            
            VStack(alignment: .leading) {
                Text(card.question)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .minimumScaleFactor(0.2)
                
                Spacer()
                Text(card.answer)
                    .font(.footnote)
                    .minimumScaleFactor(0.2)
            }
            .padding()
        }
        .containerRelativeFrame(.horizontal, count: 5, span: 2, spacing: 10)
    }
}

//#Preview {
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: FolderModel.self, configurations: config)
//    return CardViewComponent(card: CardModel(id: UUID(), question: "aa", answer: "bb"), deck: DeckModel(id: UUID(), name: "cc", folder: FolderModel(id: UUID(), name: "Test", iconName: "swift", colorName: "red")))
//}

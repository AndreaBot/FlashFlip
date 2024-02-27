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
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(Colors.setColor(using: deck.folder!.colorName))
            
            VStack(alignment: .leading) {
                Text(card.question)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                Text(card.answer)
                        .font(.title3)
                        .fontWeight(.medium)

            }
            .padding()
        }
        .frame(width: 200, height: 100)
    }
}

//#Preview {
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: FolderModel.self, configurations: config)
//    
//    return CardViewComponent(card: CardModel(id: UUID(), question: "aa", answer: "bb"), deck: DeckModel(id: UUID(), name: "cc"))
//}

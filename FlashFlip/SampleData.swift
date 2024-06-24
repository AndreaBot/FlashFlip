//
//  SampleData.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 24/06/2024.
//

import SwiftData
import Foundation

struct SampleData {
    static let sampleFolder = FolderModel(name: "Geography", iconName: "globe.desk", colorName: "blue")
    static let sampleDeck = DeckModel(name: "European capitals", folder: SampleData.sampleFolder)
    static let sampleCards = [
    CardModel(question: "Italy", answer: "Rome"),
    CardModel(question: "France", answer: "Paris"),
    CardModel(question: "Spain", answer: "Madrid"),
    CardModel(question: "Portugal", answer: "Lisbon"),
    CardModel(question: "Greece", answer: "Athens"),
    CardModel(question: "Netherlands", answer: "Amsterdam"),
    CardModel(question: "Belgium", answer: "Brussels"),
    CardModel(question: "Czech Republic", answer: "Prague"),
    CardModel(question: "Finland", answer: "Helsinki"),
    CardModel(question: "Norway", answer: "Oslo"),
    CardModel(question: "UK", answer: "London"),
    CardModel(question: "Latvia", answer: "Riga")
    ]
    
    static func createSampleFolder(_ context: ModelContext) {
        sampleDeck.cards.append(contentsOf: sampleCards)
        context.insert(sampleFolder)
    }
    
    static let welcomeMessage = "Thank you for checking out this app! I have provided some sample data to play around with but please feel free to create more folders, decks and cards as you please!"
   
}

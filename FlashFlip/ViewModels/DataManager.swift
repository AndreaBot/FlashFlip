//
//  FolderManager.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 20/05/2024.
//

import SwiftUI
import SwiftData

struct DataManager {
    
    static func clearDatabase(context: ModelContext, allFolders: [FolderModel]) {
        for i in allFolders.indices {
            context.delete(allFolders[i])
        }
    }
    
    //MARK: - Folders management
    
    static func createFolder(_ context: ModelContext, _ newFolderName: String, _ newFolderIconName: String, _ newFolderColorName: String) {
        let newFolder = FolderModel(name: newFolderName, iconName: newFolderIconName, colorName: newFolderColorName)
        withAnimation {
            context.insert(newFolder)
        }
    }
    
    static func deleteFolder(_ context: ModelContext, _ folder: FolderModel) {
        withAnimation {
            context.delete(folder)
        }
    }
    
    static func confirmChanges(_ folder: FolderModel?, _ newFolderName: String, _ newFolderIconName: String, _ newFolderColorName: String) {
        if let folder = folder {
            folder.name = newFolderName
            folder.iconName = newFolderIconName
            folder.colorName = newFolderColorName
        }
    }
    
    
    //MARK: - Decks management
    
    static func createNewDeck(_ context: ModelContext, folder: FolderModel, _ deckName: String) {
        withAnimation {
            folder.decks.append(DeckModel(name: deckName, folder: folder))
        }
    }
    
    static func deleteDeck(_ context: ModelContext, _ deck: DeckModel) {
        withAnimation {
            context.delete(deck)
        }
    }
    
    //MARK: - Cards management
    
    static func createNewCard(_ cardQuestion: String, _ cardAnswer: String, _ deck: DeckModel, _ context: ModelContext ) {
        guard !cardQuestion.isEmpty && !cardAnswer.isEmpty else {
            return
        }
        withAnimation {
            deck.cards.append(CardModel(question: cardQuestion, answer: cardAnswer))
        }
    }
}

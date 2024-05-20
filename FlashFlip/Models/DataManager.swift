//
//  FolderManager.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 20/05/2024.
//

import Foundation
import SwiftData

struct DataManager {
    
    //MARK: - Folders managment
    
    static func createFolder(_ context: ModelContext, _ newFolderName: String, _ newFolderIconName: String, _ newFolderColorName: String) {
        let newFolder = FolderModel(id: UUID(), name: newFolderName, iconName: newFolderIconName, colorName: newFolderColorName)
        context.insert(newFolder)
    }
    
    static func deleteFolder(_ context: ModelContext, _ folder: FolderModel) {
        context.delete(folder)
    }
    
    static func confirmChanges(_ folder: FolderModel?, _ newFolderName: String, _ newFolderIconName: String, _ newFolderColorName: String) {
        if let folder = folder {
            folder.name = newFolderName
            folder.iconName = newFolderIconName
            folder.colorName = newFolderColorName
        }
    }
    
    
    //MARK: - Decks managment
    
    static func createNewDeck(_ context: ModelContext, folder: FolderModel, _ deckName: String) {
        folder.decks.append(DeckModel(id: UUID(), name: deckName, folder: folder))
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func deleteDeck(_ context: ModelContext, _ deck: DeckModel) {
        context.delete(deck)
    }
    
    //MARK: - Cards managment
    
    static func createNewCard(_ cardQuestion: String, _ cardAnswer: String, _ deck: DeckModel, _ context: ModelContext ) {
        guard !cardQuestion.isEmpty && !cardAnswer.isEmpty else {
            return
        }
        
        deck.cards.append(CardModel(id: UUID(), question: cardQuestion, answer: cardAnswer))
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}


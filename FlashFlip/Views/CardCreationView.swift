//
//  CardCreationView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 27/02/2024.
//

import SwiftUI
import SwiftData

struct CardCreationView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Bindable var deck: DeckModel
    var context: ModelContext
    
    @State private var cardQuestion = ""
    @State private var cardAnswer = ""
    
    @FocusState var txtIsFocused: Bool
    
    let cardIsBeingModified: Bool
    var card: CardModel?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.secondary
                    .ignoresSafeArea()
                
                VStack {
                    TextField("Card Question", text: $cardQuestion)
                        .focused($txtIsFocused)
                        .padding()
                        .background(.background)
                        .clipShape(Capsule())
                        .multilineTextAlignment(.center)
                    
                    TextField("Card Answer", text: $cardAnswer)
                        .padding()
                        .background(.background)
                        .clipShape(Capsule())
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Button {
                        cardIsBeingModified ? dismiss() : createNewCard()
                    } label: {
                        Text(cardIsBeingModified ? "Confirm Changes" : "Create card")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        //showCardCreation = false
                        dismiss()
                    }
                }
            }
            .onAppear{
                if let card = card {
                    cardQuestion = card.question
                    cardAnswer = card.answer
                }
                txtIsFocused = true
            }
        }
    }
    
    func createNewCard() {
        guard !cardQuestion.isEmpty && !cardAnswer.isEmpty else {
            return
        }
        
        deck.cards.append(CardModel(id: UUID(), question: cardQuestion, answer: cardAnswer))
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        cardQuestion = ""
        cardAnswer = ""
        txtIsFocused = true
    }
}

//#Preview {
//    //    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    //    let container = try! ModelContainer(for: FolderModel.self, configurations: config)
//    //
//   return CardCreationView(cardQuestion: "Q", cardAnswer: "A")
//}

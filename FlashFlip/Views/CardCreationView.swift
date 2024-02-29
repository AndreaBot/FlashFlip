//
//  CardCreationView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 27/02/2024.
//

import SwiftUI
import SwiftData

struct CardCreationView: View {
    
    @Bindable var deck: DeckModel
    var context: ModelContext
    
    @Binding var cardQuestion: String
    @Binding var cardAnswer: String
    @Binding var showCardCreation: Bool
    
    @FocusState var txtIsFocused: Bool
    
    let cardIsBeingModified: Bool
    
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
                        cardIsBeingModified ? showCardCreation.toggle() : createnewCard()
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
                        showCardCreation = false
                    }
                }
            }
            .onAppear(perform: {
                txtIsFocused = true
            })
        }
    }
    
    func createnewCard() {
        guard !cardQuestion.isEmpty && !cardAnswer.isEmpty else {
            return
        }
        
        let newCard = CardModel(id: UUID(), question: cardQuestion, answer: cardAnswer)
        deck.cards.append(newCard)
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

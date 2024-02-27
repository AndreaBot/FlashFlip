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
    
    var body: some View {
        ZStack {
            Color.secondary
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        showCardCreation = false
                    } label: {
                        Text("Done")
                            .fontWeight(.semibold)
                    }
                }
                
                Spacer()
                
                VStack {
                    TextField("Card Question", text: $cardQuestion)
                        .focused($txtIsFocused)
                        .padding()
                        .background(.background)
                        .clipShape(Capsule())
                    
                    TextField("Card Answer", text: $cardAnswer)
                        .padding()
                        .background(.background)
                        .clipShape(Capsule())
                }
                .multilineTextAlignment(.center)
                
                Spacer()
                
                Button {
                    createnewCard()
                } label: {
                    Text("Create card")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .onAppear(perform: {
            txtIsFocused = true
        })
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
    }
}

//#Preview {
//    //    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    //    let container = try! ModelContainer(for: FolderModel.self, configurations: config)
//    //
//   return CardCreationView(cardQuestion: "Q", cardAnswer: "A")
//}

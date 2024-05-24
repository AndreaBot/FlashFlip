//
//  CardsCarouselView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 28/02/2024.
//

import SwiftUI
import SwiftData


struct CardsCarouselView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var deck: DeckModel
    var context: ModelContext
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State private var selectedCard: CardModel?
    @State private var showCardCreation = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { metrics in
                if !deck.cards.isEmpty {
                    VStack {
                        ZStack {
                            ForEach(0..<deck.cards.count, id: \.self) { index in
                                if (0..<deck.cards.count).contains(index) {
                                    let widthMod = CGFloat(index - currentIndex) * metrics.size.width
                                    
                                    CardViewComponent(card: deck.cards[index], deck: deck)
                                        .opacity(currentIndex == index ? 1.0 : 0.5)
                                        .scaleEffect(currentIndex == index ? 2 : 1.5)
                                        .offset(x: widthMod * 0.7 + dragOffset, y: 0)
                                        .frame(width: metrics.size.width, height: metrics.size.height * 0.35)
                                        .transition(.push(from: .bottom))
                                }
                            }
                            .frame(height: 500)
                        }
                        Spacer()
                        
                        HStack {
                            Button {
                                withAnimation {
                                    currentIndex = max(0, currentIndex - 1)
                                }
                            } label: {
                                Image(systemName: "arrowshape.left.circle")
                                    .font(.largeTitle)
                            }
                            .disabled(currentIndex == 0)
                            
                            Spacer()
                            CardStatsViewComponent(card: deck.cards[currentIndex])
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    currentIndex = min(deck.cards.count - 1, currentIndex + 1)
                                }
                            } label: {
                                Image(systemName: "arrowshape.right.circle")
                                    .font(.largeTitle)
                            }
                            .disabled(currentIndex == deck.cards.count - 1)
                        }
                        
                        VStack(spacing: 20) {
                            Button {
                                selectedCard = deck.cards[currentIndex]
                            } label: {
                                Text("Edit Card")
                                    .padding(.horizontal)
                                    .font(.title2)
                            }
                            
                            Button(role: .destructive) {
                                if (0..<deck.cards.count).contains(currentIndex) {
                                    withAnimation {
                                        deck.cards.remove(at: currentIndex)
                                        
                                        if currentIndex == deck.cards.count {
                                            currentIndex -= 1
                                        }
                                    
                                    }
                                    
                                }
                            } label: {
                                Text("Delete Card")
                                    .padding(.horizontal)
                                    .font(.title2)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                let threshold: CGFloat = 50
                                if value.translation.width > threshold {
                                    withAnimation {
                                        currentIndex = max(0, currentIndex - 1)
                                    }
                                } else if value.translation.width < -threshold {
                                    withAnimation {
                                        currentIndex = min(deck.cards.count - 1, currentIndex + 1)
                                    }
                                }
                            }
                    )
                } else {
                    ContentUnavailableView {
                        Label("Your deck is empty", systemImage: "square.3.layers.3d.slash")
                    } description: {
                        Text("Tap the + button to start adding cards to the deck")
                    } actions: {
                        Button {
                            showCardCreation = true
                        } label: {
                            Image(systemName: "plus")
                                .symbolVariant(.circle)
                                .font(.title)
                        }
                    }
                }
            }
            .navigationTitle("\(deck.name)")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        showCardCreation = true
                    } label: {
                        Image(systemName: "plus")
                            .fontWeight(.semibold)
                    }
                }
            }
            .sheet(item: $selectedCard) { cardModel in
                CardCreationView(deck: deck, context: context, cardIsBeingModified: true, card: cardModel)
                    .presentationDetents([.fraction(0.34)])
            }
            .sheet(isPresented: $showCardCreation) {
                CardCreationView(deck: deck, context: context, cardIsBeingModified: false)
                    .presentationDetents([.fraction(0.34)])
            }
        }
    }
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: FolderModel.self, configurations: config)
    
    return  CardsCarouselView (deck: DeckModel(id: UUID(), name: "Test"), context: ModelContext(container))
}

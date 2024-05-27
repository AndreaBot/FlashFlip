//
//  CardCarouselView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 25/05/2024.
//


import SwiftData
import SwiftUI

struct CardCarouselView: View {
    
    var context: ModelContext
    @State private var currentIndex = 0
    @Binding var deck: DeckModel
    @State private var selectedCard: CardModel?
    @GestureState private var dragOffset: CGFloat = 0
    
    var body: some View {
        GeometryReader { metrics in
            VStack {
                Spacer()
                ZStack {
                    ForEach(0..<deck.cards.count, id: \.self) { index in
                        if (0..<deck.cards.count).contains(index) {
                            let widthMod = CGFloat(index - currentIndex) * metrics.size.width
                            
                            CardViewComponent(card: deck.cards.sorted()[index], deck: deck)
                                .opacity(currentIndex == index ? 1.0 : 0.5)
                                .scaleEffect(currentIndex == index ? 2 : 1.5)
                                .offset(x: widthMod * 0.7 + dragOffset, y: 0)
                                .frame(width: metrics.size.width, height: metrics.size.height * 0.35)
                                .transition(.push(from: .bottom))
                        }
                    }
                    .frame(height: metrics.size.height * 0.6)
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
                    if (0..<deck.cards.count).contains(currentIndex) {
                        CardStatsViewComponent(card: deck.cards.sorted()[currentIndex])
                    }
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
                
                VStack {
                    Button {
                        selectedCard = deck.cards.sorted()[currentIndex]
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
            .sheet(item: $selectedCard) { cardModel in
                CardCreationView(deck: deck, context: context, cardIsBeingModified: true, card: cardModel)
                    .presentationDetents([.fraction(0.34)])
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
        }
    }
}

//#Preview {
//    CardCarouselView()
//}

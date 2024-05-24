//
//  SwipeAnimation.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 24/05/2024.
//

import SwiftUI

struct SwipeAnimation: ViewModifier {
    
    let index: Int
    let currentIndex: Int
    let scale: CGSize
    let smallScale: CGSize
    
    func body(content: Content) -> some View {
        content
            .offset(x: index == currentIndex ? 0 : -45, y: 0)
            .transition(.slide.combined(with: .move(edge: .trailing)).combined(with: .opacity))
            .scaleEffect(index == currentIndex ? scale : smallScale)
            .rotationEffect(.degrees(index == currentIndex ? 0 : -10))
    }
}

extension View {
    func customSwipeAnimation(index: Int, currentIndex: Int, scale: CGSize, smallScale: CGSize)  -> some View{
        modifier(SwipeAnimation(index: index, currentIndex: currentIndex, scale: scale, smallScale: smallScale))
    }
}



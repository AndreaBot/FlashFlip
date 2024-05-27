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
    let edge: Edge
    
    func body(content: Content) -> some View {
        content
            .offset(x: index == currentIndex ? 0 : -45, y: 0)
            .transition(.push(from: edge))
            .scaleEffect(index == currentIndex ? scale : smallScale)
            .rotationEffect(.degrees(index == currentIndex ? 0 : -10))
        
    }
}

extension View {
    func customSwipeAnimation(index: Int, currentIndex: Int, scale: CGSize, smallScale: CGSize, edge: Edge)  -> some View{
        modifier(SwipeAnimation(index: index, currentIndex: currentIndex, scale: scale, smallScale: smallScale, edge: edge))
    }
}



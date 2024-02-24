//
//  IconGridViewComponent.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 24/02/2024.
//

import SwiftUI

struct IconsGridItemView: View {
    
    var iconName: String
    var isSelected: Bool
    
    var body: some View {
        Image(systemName: iconName)
            .resizable()
            .scaledToFit()
        .frame(width: 40, height: 40)
            .padding(10)
            .overlay {
                Circle()
                    .stroke(.mint, lineWidth: isSelected ? 3 : 0)
            }
    }
}

#Preview {
    IconsGridItemView(iconName: "swift", isSelected: true)
}

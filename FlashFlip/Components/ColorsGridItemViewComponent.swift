//
//  ColorsGridItemView.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 24/02/2024.
//

import SwiftUI

struct ColorsGridItemViewComponent: View {
    var iconColor: String
    var isSelected: Bool
    
    var body: some View {
        Circle()
            .frame(width: 45, height: 45)
            .padding(10)
            .foregroundStyle((Colors.setColor(using: iconColor)))
            .overlay {
                Circle()
                    .stroke(.mint, lineWidth: isSelected ? 4 : 0)
            }
    }
}

#Preview {
    ColorsGridItemViewComponent(iconColor: "purple", isSelected: true)
}

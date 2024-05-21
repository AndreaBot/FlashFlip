//
//  AddButtonComponent.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 26/02/2024.
//

import SwiftUI

struct CreateElementComponent: View {
    
    let height: CGFloat
    let text: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "plus")
                .resizable()
                .scaledToFit()
            
            Text(text)
        }
        .fontWeight(.heavy)
        .padding()
        .frame(height: height)
        .containerRelativeFrame(.horizontal) { size, axis in
            size
        }
        .background(Color.primary).opacity(0.2)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    CreateElementComponent(height: 150, text: "Create new folder")
}

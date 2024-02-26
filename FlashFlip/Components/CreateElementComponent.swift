//
//  AddButtonComponent.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 26/02/2024.
//

import SwiftUI

struct CreateElementComponent: View {
    
    let height: CGFloat
    
    var body: some View {
        Image(systemName: "plus")
            .resizable()
            .scaledToFit()
            .fontWeight(.heavy)
            .padding(20)
            .frame(height: height)
            .containerRelativeFrame(.horizontal) { size, axis in
                size * 0.9
            }
            .background(Color.primary).opacity(0.2)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    CreateElementComponent(height: 150)
}

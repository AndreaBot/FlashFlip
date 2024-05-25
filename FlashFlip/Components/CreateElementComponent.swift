//
//  AddButtonComponent.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 26/02/2024.
//

import SwiftUI

struct CreateElementComponent: View {

    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "plus")
                .resizable()
                .scaledToFit()
                .symbolVariant(.circle)
                .foregroundStyle(.blue)
            Spacer()
        }
        .fontWeight(.semibold)
        .padding(.top)
        .frame(height: 60)
    }
}

#Preview {
    CreateElementComponent()
}

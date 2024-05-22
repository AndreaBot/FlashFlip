//
//  MarkButtonsStack.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 22/05/2024.
//

import SwiftUI

struct MarkButtonsStack: View {
    
    @Binding var card: CardModel
    @Binding var viewModel: StudySessionViewModel
    
    var body: some View {
        HStack {
            Spacer()
            
            Button {
                card.swipeAmount += 180
                viewModel.progressGame(mark: "correct")
            } label: {
                Image(systemName: "checkmark")
                    .font(.largeTitle).fontWeight(.bold)
            }
            .padding()
            .foregroundStyle(.background)
            .background(.green)
            .clipShape(Circle())
            
            Spacer()
            
            Button {
                card.swipeAmount += 180
                viewModel.progressGame(mark: "wrong")
            } label: {
                Image(systemName: "xmark")
                    .font(.largeTitle).fontWeight(.bold)
            }
            
            .padding()
            .foregroundStyle(.background)
            .background(.red)
            .clipShape(Circle())
            
            Spacer()
        }
        .padding(.vertical)
    }
}

//#Preview {
//    MarkButtonsStack()
//}

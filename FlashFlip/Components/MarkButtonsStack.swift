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

//
//  Colors.swift
//  FlashFlip
//
//  Created by Andrea Bottino on 24/02/2024.
//

import SwiftUI

struct Colors {
    
    static let allColors = [
    "red",
    "orange",
    "yellow",
    "green",
    "mint",
    "cyan",
    "blue",
    "indigo",
    "purple",
    "pink",
    "brown",
    "gray"
    ]
    
    static func setColor(using colorName: String) -> Color {
        switch colorName {
        case "red": return .red
        case "orange": return .orange
        case "yellow": return .yellow
        case "green": return .green
        case "cyan": return .cyan
        case "mint": return .mint
        case "blue": return .blue
        case "indigo": return .indigo
        case "purple": return .purple
        case "pink": return .pink
        case "brown": return .brown
        case "gray": return .gray
        default:
            return .gray
        }
    }
}

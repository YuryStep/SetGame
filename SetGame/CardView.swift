//
//  CardView.swift
//  SetCardGame
//
//  Created by Юрий Степанчук on 16.02.2023.
//

import SwiftUI

struct CardView: View {
    
    var card: ClassicSetGame.Card
    
    var body: some View {
            cardFace.cardShell(isFaceUp: !card.inDeck,
                               insideColor: insideColor,
                               borderColor: CardConstants.borderColor)
    }
    
    var cardFace: some View {
        var colorOfSymbol: Color {
            switch card.color {
            case .green : return .green
            case .red : return .red
            case .purple : return .purple
            }
        }
        var shadingOpacity: Double {
            switch card.shading {
            case .solid : return 1
            case .striped : return 0.2
            case .open : return 0
            }
        }
        let symbol = ZStack {
            switch card.symbol {
            case .diamond :
                Squiggle().opacity(shadingOpacity)
                Squiggle().stroke(lineWidth: CardConstants.lineWidthOfSymbol)
            case .squiggle :
                Dimond().opacity(shadingOpacity)
                Dimond().stroke(lineWidth: CardConstants.lineWidthOfSymbol)
            case .oval :
                Capsule().opacity(shadingOpacity)
                Capsule().stroke(lineWidth: CardConstants.lineWidthOfSymbol)
            }
        }
            .foregroundColor(colorOfSymbol)
            .aspectRatio(CardConstants.symbolAspectRatio, contentMode: .fit)
        
        return VStack {
            if card.value == 1 {
                symbol
            } else if card.value == 2 {
                symbol
                symbol
            } else {
                symbol
                symbol
                symbol
            }
        }
        .padding(CardConstants.paddingOfSymbols)
    }
    
    var insideColor: Color {
        if let matchingStatus = card.isMatched {
            if card.inGame {
                return matchingStatus ?
                CardConstants.matchedCardColor :
                CardConstants.failedMatchCardColor
            } else {
                return CardConstants.defaultCardColor
            }
        }
        return card.isSelected ?
        CardConstants.selectedCardColor :
        CardConstants.defaultCardColor
    }
    
    private struct CardConstants {
        // Geometric parameters:
        static let cornerRadiusOfCard: CGFloat = 15
        static let lineWidthOfCard: CGFloat = 1
        static let symbolAspectRatio = CGSize(width: 2, height: 1)
        static let lineWidthOfSymbol: CGFloat = 2
        static let paddingOfSymbols: CGFloat = 15
        // Colors:
        static let defaultCardColor = Color(white: 0.96)
        static let selectedCardColor = Color(red: 255/255, green: 229/255, blue: 153/255) // LightYellow
        static let matchedCardColor = Color(red: 152/255, green: 240/255, blue: 152/255) // LightGreen
        static let failedMatchCardColor = Color(red: 244/255, green: 204/255, blue: 204/255) // lightRed
        static let borderColor: Color = .gray
    }
}

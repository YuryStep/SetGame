//
//  CardShell.swift
//  SetCardGame
//
//  Created by Юрий Степанчук on 24.02.2023.
//

import SwiftUI

struct CardShell: ViewModifier, Animatable {
    
    // Varibles:
    var isFaceUp: Bool
    var insideColor: Color
    var borderColor: Color

    // Body:
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: ShapeConstants.cornerRadiusOfCard)
            shape
                .foregroundColor(insideColor)
            shape
                .strokeBorder(lineWidth: ShapeConstants.lineWidthOfCard)
                .foregroundColor(borderColor)
            content
                .opacity(isFaceUp ? 1 : 0)
        }
    }
    
    // Constants:
    private struct ShapeConstants {
        static let cornerRadiusOfCard: CGFloat = 15
        static let lineWidthOfCard: CGFloat = 1
    }
}

// A short ".cardShell" sintax implementation of ViewModifier
extension View {
    func cardShell(isFaceUp: Bool, insideColor: Color, borderColor: Color) -> some View {
        self.modifier(CardShell(isFaceUp: isFaceUp,
                                insideColor: insideColor,
                                borderColor: borderColor))
    }
}

// A custom transition with card rotation
extension AnyTransition {
    static var cardFlipper: AnyTransition {
        return AnyTransition.modifier(
            active: RotationAngleModifier(rotationAngle: 0),
            identity: RotationAngleModifier(rotationAngle: 180))
    }
}
struct RotationAngleModifier: ViewModifier {
    let rotationAngle: Double
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(Angle.degrees(rotationAngle), axis: (x: 0, y: 1, z: 0))
            .opacity(rotationAngle < 90 ? 0 : 1)
            .clipped()
    }
}

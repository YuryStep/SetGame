//
//  Squiggle.swift
//  SetCardGame
//
//  Created by Юрий Степанчук on 15.02.2023.
//

import SwiftUI

struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
        
        
        let pointA = CGPoint(x: rect.midX - 1.4/22 * rect.width, y: rect.midY + 3.5/10 * rect.height)
        let pointA1 = CGPoint(x: rect.midX + 6/22 * rect.width, y: rect.midY + 0/10 * rect.height)
        let pointA2 = CGPoint(x: rect.midX + 6.5/22 * rect.width, y: rect.midY + 7/10 * rect.height)
        let pointB = CGPoint(x: rect.midX + 9/22 * rect.width, y: rect.midY + 4/10 * rect.height)
        
        let pointB1 = CGPoint(x: rect.midX + 11/22 * rect.width, y: rect.midY + 1.3/10 * rect.height)
        let pointB2 = CGPoint(x: rect.midX + 7.5/22 * rect.width, y: rect.midY - 5.7/10 * rect.height)
        let pointC = CGPoint(x: rect.midX + 1/22 * rect.width, y: rect.midY - 4/10 * rect.height)
        
        let pointC1 = CGPoint(x: rect.midX - 1.2/22 * rect.width, y: rect.midY - 3.3/10 * rect.height)
        let pointC2 = CGPoint(x: rect.midX - 2.3/22 * rect.width, y: rect.midY - 2.5/10 * rect.height)
        let pointD = CGPoint(x: rect.midX - 4.4/22 * rect.width, y: rect.midY - 3/10 * rect.height)
        
        let pointD1 = CGPoint(x: rect.midX - 6.3/22 * rect.width, y: rect.midY - 3.8/10 * rect.height)
        let pointD2 = CGPoint(x: rect.midX - 9/22 * rect.width, y: rect.midY - 7.5/10 * rect.height)
        let pointE = CGPoint(x: rect.midX - 10/22 * rect.width, y: rect.midY - 2.8/10 * rect.height)
        
        let pointE1 = CGPoint(x: rect.midX - 10.8/22 * rect.width, y: rect.midY + 3.5/10 * rect.height)
        let pointE2 = CGPoint(x: rect.midX - 5.8/22 * rect.width, y: rect.midY + 5.8/10 * rect.height)
        
        var p = Path()
        p.move(to: pointA)
        p.addCurve(to: pointB, control1: pointA1, control2: pointA2)
        p.addCurve(to: pointC, control1: pointB1, control2: pointB2)
        p.addCurve(to: pointD, control1: pointC1, control2: pointC2)
        p.addCurve(to: pointE, control1: pointD1, control2: pointD2)
        p.addCurve(to: pointA, control1: pointE1, control2: pointE2)
        
        return p
    }
    
}




//
//  Dimond.swift
//  SetCardGame
//
//  Created by Юрий Степанчук on 14.02.2023.
//

import SwiftUI

struct Dimond: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let DimondHeight = rect.height / 2
        let DimondWidth = rect.width / 2
        
        let pointA = CGPoint(x: rect.midX, y: rect.midY + DimondHeight)
        let pointB = CGPoint(x: rect.midX - DimondWidth, y: rect.midY)
        let pointC = CGPoint(x: rect.midX, y: rect.midY - DimondHeight)
        let pointD = CGPoint(x: rect.midX + DimondWidth , y: rect.midY)

        var p = Path()
        p.move(to: pointA)
        p.addLine(to: pointB)
        p.addLine(to: pointC)
        p.addLine(to: pointD)
        p.addLine(to: pointA)
        return p
    }
}

//
//  SetCardGameApp.swift
//  SetCardGame
//
//  Created by Юрий Степанчук on 13.02.2023.
//

import SwiftUI

@main
struct SetCardGameApp: App {
    var game = ClassicSetGame()
    var body: some Scene {
        WindowGroup {
            SetGameView(game: game)
        }
    }
}

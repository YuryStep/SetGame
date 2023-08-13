//
//  SetGameView.swift
//  SetCardGame
//
//  Created by Юрий Степанчук on 13.02.2023.
//

import SwiftUI

struct SetGameView: View {
    
    @ObservedObject var game: ClassicSetGame
    @Namespace private var cardsNamespace
    
    var body: some View {
        VStack {
            gameBody
            Divider()
            HStack {
                VStack {
                    deckBody
                    Text("\(game.cards.filter { $0.inDeck }.count) of 81")
                }
                Spacer()
                VStack {
                    Text("Score: \(game.score)")
                        .fontWeight(.bold)
                    Group {
                        Button("Cheat") { }
                        .foregroundColor(game.cheat() ? .green : .red)
                        Button("Restart") {
                            withAnimation {
                                game.startNewGame()
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
                Spacer()
                VStack {
                    discardPileBody
                    Text("Set Found: \(game.score)")
                }
            }
        }
        .padding(20)
    }
    
    var tempTable: [ClassicSetGame.Card] {
        get {
            game.cards
        }
    }
    
    
    // MARK: Игровой стол
    var gameBody: some View {
        return VStack {
            AspectVGrid(items: game.cards,
                        aspectRatio: CardConstants.aspectRatioOfCard) { card in
                if card.inGame {
                    CardView(card: card)
                        .matchedGeometryEffect(id: card.id, in: cardsNamespace)
//                        .transition(AnyTransition.asymmetric(
//                            insertion: (AnyTransition.cardFlipper.animation(.default.delay(0.3))),
//                            removal: (AnyTransition.slide))) // Try to flip it back
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                game.choose(card)
                            }
                        }
                        .padding(CardConstants.paddingOfCard)
                }
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: Коллода
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter{ $0.inDeck }) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: cardsNamespace)
                    .transition(AnyTransition.slide)
            }
        }
        .frame(width: CardConstants.deckWidth, height: CardConstants.deckHeight)
        .onTapGesture {
            // Deal cards
            withAnimation(.easeInOut(duration: 0.3)) {
                    game.addMoreCards()
            }
        }
    }
    
    // MARK: Отбой
    var discardPileBody: some View {
        ZStack {
            let cardsInPile = game.cards.filter {!$0.inGame && !$0.inDeck}
            if !cardsInPile.isEmpty {
                ForEach(cardsInPile) { card in
                    CardView(card: card)
                        .matchedGeometryEffect(id: card.id, in: cardsNamespace)
                    // Rotation degree should be refactored to universal method
                        .rotationEffect(Angle(degrees: Double(card.id > 40 ? card.id/8 : card.id/(-8))))
                        .transition(AnyTransition.slide)
                        .frame(width: CardConstants.deckWidth, height: CardConstants.deckHeight)
                }
            } else {
                // Placeholder
                Color.clear
                    .frame(width: CardConstants.deckWidth, height: CardConstants.deckHeight)
            }
        }
    }
    
    struct CardConstants {
        static let aspectRatioOfCard: CGFloat = 2/3
        static let paddingOfCard: CGFloat = 4
        static let deckHeight: CGFloat = 140
        static let deckWidth = deckHeight * aspectRatioOfCard
        
        static let dealDuration: Double = 3
        static let totalDealDuration: Double = 2
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = ClassicSetGame()
        SetGameView(game: game)
    }
}

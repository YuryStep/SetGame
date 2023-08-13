//
//  SetGame.swift
//  SetCardGame
//
//  Created by Юрий Степанчук on 13.02.2023.
//

import Foundation

struct SetGame<Symbol: Equatable, Shading: Equatable, SymbolColor: Equatable> {
    var cards: [Card]
    
    private (set) var gameScore = 0
    private var selectedCards: [Card] { cards.filter { $0.isSelected } } // FIX: change to ID implementation
    
    func setIsPossible (cards: [Card]) -> Bool {
        let cardsOnTable = cards
        let numberOfCards = cardsOnTable.count
        guard numberOfCards > 2 else {
            return false
        }
        let firstIndex = 0
        var secondIndex = 1
        var thirdIndex = 2
        
        while thirdIndex < numberOfCards {
            let card1 = cardsOnTable[firstIndex]
            let card2 = cardsOnTable[secondIndex]
            let card3 = cardsOnTable[thirdIndex]
            if setDetected(card1: card1, card2: card2, card3: card3) {
                return true
            }
            secondIndex += 1
            thirdIndex += 1
        }
        return setIsPossible(cards: [Card](cardsOnTable.dropFirst(1)))
    }
    
    func setDetected(card1: Card, card2: Card, card3: Card) -> Bool {
        if card1.symbol == card2.symbol &&
            card1.symbol == card3.symbol ||
            card1.symbol != card2.symbol &&
            card1.symbol != card3.symbol &&
            card2.symbol != card3.symbol {
            if card1.color == card2.color &&
                card1.color == card3.color ||
                card1.color != card2.color &&
                card1.color != card3.color &&
                card2.color != card3.color {
                if card1.shading == card2.shading &&
                    card1.shading == card3.shading ||
                    card1.shading != card2.shading &&
                    card1.shading != card3.shading &&
                    card2.shading != card3.shading {
                    if card1.value == card2.value &&
                        card1.value == card3.value ||
                        card1.value != card2.value &&
                        card1.value != card3.value &&
                        card2.value != card3.value {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    // Game logic
    private var setIsOnTable: Bool {
        if selectedCards.count == 3 {
            let card1 = selectedCards[0]
            let card2 = selectedCards[1]
            let card3 = selectedCards[2]
            return setDetected(card1: card1, card2: card2, card3: card3)
        }
        return false
    }
    
    private mutating func cleanSelection() {
        for index in cards.indices { cards[index].isSelected = false }
    }
    
    mutating func choose(_ card: Card) {
        if let indexOfChosenCard = cards.firstIndex(where: { $0.id == card.id}) {
            if selectedCards.count <= 2 {
                cards[indexOfChosenCard].isSelected.toggle()
                if selectedCards.count == 3 {
                    for index in cards.indices {
                        if cards[index].isSelected {
                            cards[index].isMatched = setIsOnTable
                        }
                    }
                }
            } else {
                if setIsOnTable {
                    for index in cards.indices {
                        if cards[index].isSelected {
                            cards[index].inGame = false
                        }
                    }
                    dealMoreCards()
                } else {
                    for index in cards.indices {
                        if cards[index].isSelected {
                            cards[index].isMatched = nil
                        }
                    }
                }
                cleanSelection()
                if cards[indexOfChosenCard].isMatched != true {
                    cards[indexOfChosenCard].isSelected.toggle()
                }
            }
        }
    }
    
    mutating func dealMoreCards() {
        if setIsOnTable {
            for index in cards.indices {
                if cards[index].isSelected {
                    cards[index].inGame = false
                }
            }
            cleanSelection()
            gameScore += 1
        }
        let numberOfCards = cards.filter({$0.inGame}).count == 0 ? 12 : 3
        for _ in 0..<numberOfCards {
            if let index = cards.firstIndex(where: {$0.inDeck} ) {
                cards[index].inGame = true
            }
        }
    }
    
    struct Card: Identifiable {
        let symbol: Symbol
        let shading: Shading
        let color: SymbolColor
        let value: Int
        
        var inGame = false
//        var isFaceUp = false // New
        var isSelected = false
        var isMatched: Bool?
        var inDeck: Bool {
            !self.inGame && self.isMatched != true
        }
        let id: Int
    }
    
}

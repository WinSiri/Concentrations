//
//  Concentration.swift
//  Concentrations
//
//  Created by Kwin Sirikwin on 30/4/20.
//  Copyright © 2020 Kwin Sirikwin. All rights reserved.
//

import Foundation

class Concentration {
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
 
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards!")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            // append card and matching card
            cards += [card, card]
        }
        // TODO: Shuffle the cards
        cards.shuffle()
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        /*
         3 Conditions can happen.
         - 1 card is already face up -> check if card match
         - No card is face up
         - 2 cards are face up
         */
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                // Now 2 cards have already opened
            } else {
                // either no card or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func reset() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        cards.shuffle()
    }
}

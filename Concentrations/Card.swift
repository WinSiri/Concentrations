//
//  Card.swift
//  Concentrations
//
//  Created by Kwin Sirikwin on 30/4/20.
//  Copyright © 2020 Kwin Sirikwin. All rights reserved.
//

import Foundation

struct Card: Hashable { 
    var hashValue: Int { return identifier }
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(identifier)
//    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    private static func getUniqueIdentifier() -> Int {
        // Card.identifierFactory += 1
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}

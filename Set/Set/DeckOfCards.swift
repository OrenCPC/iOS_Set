//
//  DeckOfCards.swift
//  Set
//
//  Created by Oren Dinur on 15/02/2022.
//

import UIKit
import Foundation

class DeckOfCards {
        
    private static var deck = Array <Card>()
    
    static func getInitialDeck() -> [Card] {
        self.deck = []
        for typeOfNumber in Card.CardNumber.allCases {
            for typeOfShape in Card.CardShape.allCases {
                for typeOfShade in Card.CardShade.allCases {
                    for typeOfColor in Card.CardColor.allCases {
                        let card = Card(number: typeOfNumber, shape: typeOfShape, shading: typeOfShade, color: typeOfColor)
                        deck += [card]
                    }
                }
            }
        }
        return deck
    }
}

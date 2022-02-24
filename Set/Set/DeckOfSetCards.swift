//
//  DeckOfCards.swift
//  Set
//
//  Created by Oren Dinur on 15/02/2022.
//

import UIKit
import Foundation

class DeckOfSetCards {
        
    private static var deck = Array <SetCard>()
    
    static func getInitialDeck() -> [SetCard] {
        self.deck = []
        for typeOfNumber in SetCard.CardNumber.allCases {
            for typeOfShape in SetCard.CardShape.allCases {
                for typeOfShade in SetCard.CardShade.allCases {
                    for typeOfColor in SetCard.CardColor.allCases {
                        let card = SetCard(number: typeOfNumber, shape: typeOfShape, shading: typeOfShade, color: typeOfColor)
                        deck += [card]
                    }
                }
            }
        }
        return deck
    }
}

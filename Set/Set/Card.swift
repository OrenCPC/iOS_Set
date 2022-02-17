//
//  Card.swift
//  Set
//
//  Created by Oren Dinur on 14/02/2022.
//

import Foundation
import UIKit

struct Card: Hashable, Equatable {
    
    var hashValue: Int { return identifier }
    
//    let number: DeckOfCards.CardNumber
//    let shape: DeckOfCards.CardShape
//    let shading : DeckOfCards.CardShade
//    let color : DeckOfCards.CardColor
    
    let number: Int
    let shape: String
    let shading : DeckOfCards.CardShade
    let color : UIColor
    
    private var identifier: Int
    
    private static var identifierFactory = 0

        
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
   private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(number: DeckOfCards.CardNumber, shape: DeckOfCards.CardShape, shading: DeckOfCards.CardShade, color: DeckOfCards.CardColor) {
        
        self.identifier = Card.getUniqueIdentifier()
        self.number = number.getNumberInt()
        self.shape = shape.getShapeString()
        self.shading = shading
        self.color = color.getUIColor()
    }
}

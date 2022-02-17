//
//  DeckOfCards.swift
//  Set
//
//  Created by Oren Dinur on 15/02/2022.
//

import UIKit
import Foundation

class DeckOfCards {
    
    enum CardNumber: CaseIterable {
        case first, second, third
        
        func getNumberInt() -> Int {
            switch self {
            case .first:
                return 1
            case .second:
                return 2
            case .third:
                return 3
            }
        }
    }
    
    enum CardShape: CaseIterable {
        case circle, triangle, square
        
        func getShapeString() -> String {
            switch self {
            case .circle:
                return "●"
            case .triangle:
                return "▲"
            case .square:
                return "■"
            }
        }
    }
    
    enum CardShade: CaseIterable {
        case solid, striped, open
    }
    
    enum CardColor: CaseIterable {
        case red, green, purple
        
        func getUIColor() -> UIColor {
            switch self {
            case .red:
                return UIColor.red
            case .green:
                return UIColor.green
            case .purple:
                return UIColor.purple
            }
        }
    }
    
    private static var deck = Array <Card>()
    
    static func getInitialDeck() -> [Card] {
        self.deck = []
        for typeOfNumber in CardNumber.allCases {
            for typeOfShape in CardShape.allCases {
                for typeOfShade in CardShade.allCases {
                    for typeOfColor in CardColor.allCases {
                        let card = Card(number: typeOfNumber, shape: typeOfShape, shading: typeOfShade, color: typeOfColor)
                        deck += [card]
                    }
                }
            }
        }
        return deck
    }
    
}

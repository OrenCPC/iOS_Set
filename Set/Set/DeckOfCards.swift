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
    
    private static var numbersArray = [1,2,3]
//    private static enum numbers {
//        case 1: 1
//        case 2: 2
//    }
    
    private static var shapesArray = ["▲","●","■"]
    
    private static var shadingArray = ["solid", "striped", "open"]
    
    private static var colorsArray = [UIColor.red, UIColor.green,  UIColor.purple]
    
    
    static func getInitialDeck() -> [Card] {
        self.deck = []
        for number in numbersArray.indices {
            for shape in shapesArray.indices {
                for shade in shadingArray.indices {
                    for clr in colorsArray.indices {
                        let card = Card(number: numbersArray[number], shape: shapesArray[shape], shading: shadingArray[shade], color: colorsArray[clr])
                        deck += [card]
                    }
                }
            }
        }
        return deck
    }
    
}

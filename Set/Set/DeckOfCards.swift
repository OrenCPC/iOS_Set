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
    private static var numbersIterator = 0
    
    private static var shapesArray = ["diamond","squiggle","oval"]
    private static var shapesIterator = 0
    
    private static var shadingArray = ["solid", "striped", "open"]
    private static var shadingIterator = 0
    
    private static var colorsArray = [UIColor.red, UIColor.green,  UIColor.purple]
    private static var colorsIterator = 0
    
    private static func getNumber() -> Int {
        let temp = numbersIterator
        numbersIterator = (numbersIterator + 1) % 3
        return numbersArray[temp]
    }
    
    private static func getShape() -> String {
        let temp = shapesIterator
        shapesIterator = (shapesIterator + 1) % 3
        return shapesArray[temp]
    }
    
    private static func getShade() -> String {
        let temp = shadingIterator
        shadingIterator = (shadingIterator + 1) % 3
        return shadingArray[temp]
    }
    
    private static func getColors() -> UIColor {
        let temp = colorsIterator
        colorsIterator = (colorsIterator + 1) % 3
        return colorsArray[temp]
    }
    
    static func getInitialDeck() -> [Card] {
        for _ in 1...81 {
            let card = Card(number: getNumber(), shape: getShape(), shading: getShade(), color: getColors())
            deck += [card]
        }
        return deck
    }
    
}

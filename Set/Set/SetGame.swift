//
//  SetGame.swift
//  Set
//
//  Created by Oren Dinur on 14/02/2022.
//

import Foundation
import UIKit

struct SetGame {
    
    //TODO:
    
    private(set) var cards = Array <Card>()
    
    private var clickedCards = Array <Card>()
    
    private var matchedCards = Array <Card>()

    
    mutating func addCardIndexToClickedCards(index: Int) {
        clickedCards += [cards[index]]
    }
    
    mutating func addCardIndexToMatchedCards(index: Int) {
        matchedCards += [cards[index]]
    }
    
    mutating func clearClickedCardsArray () {
        clickedCards = []
    }

    mutating func checkForMatch(index: Int){
        addCardIndexToClickedCards(index: index)
//        let sets: (numbersSet: Set<Int>, symbolsSet: Set<String>, shadingsSet: Set<String>, colorsSet: Set<UIColor>)
        var numbersSet = Set<Int>()
        var shapesSet = Set<String>()
        var shadingsSet = Set<String>()
        var colorsSet = Set<UIColor>()
        
        for index in clickedCards.indices {
            numbersSet.insert(clickedCards[index].number)
            shapesSet.insert(clickedCards[index].shape)
            shadingsSet.insert(clickedCards[index].shading)
            colorsSet.insert(clickedCards[index].color)
        }
        
        var score = 0
        if numbersSet.count != 2 { score += 1 }
        if shapesSet.count != 2 { score += 1 }
        if shadingsSet.count != 2 { score += 1 }
        if colorsSet.count != 2 { score += 1 }
        
        if score == 4 {
            for index in clickedCards.indices{
                addCardIndexToMatchedCards(index: index)
            }
        }
        clearClickedCardsArray()
    }
    
        mutating func chooseCard(at index: Int) {
//            assert(cards.indices.contains(index), "SetGame.chooseCard(at: \(index)): chosen index not in the cards")
            switch(clickedCards.count){
            
            case 0,1: addCardIndexToClickedCards(index: index)
                
            case 2: checkForMatch(index: index)
            
            case 3:
                clearClickedCardsArray()
                addCardIndexToClickedCards(index: index)
                
            default:
                break
            }
        }
    
    
    init(numberOfCards: Int) {
        cards = DeckOfCards.getInitialDeck()
        print(cards)
        cards.shuffle()
    }
}
    
    /*
     עבור כל אחד מהמאפיינים בנפרד, שלושת הקלפים זהים זה לזה או שונים זה מזה. לדוגמה, שלושה קלפים שבכל אחד מהם מעוין אחד מלא בצבע שונה הם סט. דוגמה נוספת: שלושה קלפים שבכל אחד צורה אחרת, צבע אחר, אבל כולם מפוספסים ובכמות 1 – גם הם סט.
     */

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
    
    var cards = Array <Card>()
    
    private(set) var clickedCards = Array <Card>()
    
    private(set) var cardChoices = Array <Card>()
    
    private(set) var isMatch = false
    
//    private(set) var matchedCards = Array <Card>()

    
    mutating func addCardIndexToClickedCards(index: Int) {
        if !clickedCards.contains(cardChoices[index]) {
            clickedCards += [cardChoices[index]]
        } else {
            if let indexOfCardPressedTwice = clickedCards.firstIndex(of: cardChoices[index]) {
            clickedCards.remove(at: indexOfCardPressedTwice)
            }
        }
    }
    
//    mutating func addCardToMatchedCards(matchedCard: Card) {
//        matchedCards += [matchedCard]
//    }
    
    mutating func clearClickedCardsArray () {
        clickedCards = []
    }

    mutating func checkForMatch(index: Int){
        addCardIndexToClickedCards(index: index)
        //        let sets: (numbersSet: Set<Int>, symbolsSet: Set<String>, shadingsSet: Set<String>, colorsSet: Set<UIColor>)
        if clickedCards.count == 3 {
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
                isMatch = true
                
            }
        }
    }
    
    mutating func replaceCards() {
//        let cardsToReplace = clickedCards.count
        for index in clickedCards.indices {
            if cards.count > 0 {
                if let locOfCard = cardChoices.firstIndex(of: clickedCards[index]) {
                    cardChoices[locOfCard] = cards.remove(at: index)
//                    clickedCards.remove(at: index)
                }
            } else {
                break
            }
            
        }
    }
    
    mutating func fourCardsSelected(index: Int) {
        if isMatch {
            if !clickedCards.contains(cardChoices[index]) {
                replaceCards()
                clearClickedCardsArray()
                addCardIndexToClickedCards(index: index)
            } else {
                replaceCards()
                clearClickedCardsArray()
            }
            
        } else {
            clearClickedCardsArray()
            addCardIndexToClickedCards(index: index)
        }
        isMatch = false
    }
        
    
        mutating func chooseCard(at index: Int) {
//            assert(cards.indices.contains(index), "SetGame.chooseCard(at: \(index)): chosen index not in the cards")
            
            switch(clickedCards.count){
            
            case 0,1: addCardIndexToClickedCards(index: index)
                
            case 2: checkForMatch(index: index)
            
            case 3:
                fourCardsSelected(index: index)
//                clearClickedCardsArray()
//                addCardIndexToClickedCards(index: index)
            default:
                break
            }
        }
    
    mutating func addCardsToTheTableCards(number: Int) {
        
        for _ in 0...number {
            if cards.count > 0 {
                cardChoices += [cards.remove(at: 0)]
            }
            else {
                return
            }
        }
    }
    
    mutating func replaceCardsInTable(number: Int) {
        replaceCards()
        clearClickedCardsArray()
        isMatch = false
        
    }
    
    init(numberOfCards: Int) {
        cards = DeckOfCards.getInitialDeck()
        cards.shuffle()
        //need to change to 12
        for _ in 0...11 {
//            print(cards.remove(at: 0))
            cardChoices += [cards.remove(at: 0)]
        }
        clearClickedCardsArray()
    }
}
    

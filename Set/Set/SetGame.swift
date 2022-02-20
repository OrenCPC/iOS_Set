//
//  SetGame.swift
//  Set
//
//  Created by Oren Dinur on 14/02/2022.
//

import Foundation
import UIKit

struct SetGame {
    
    var cards = Array <Card>()
    
    private(set) var clickedCards = Array <Card>()
    
    private(set) var cardChoices = Array <Card>()
    
    private var previousClick: Date
    
    private(set) var isMatch = false
    
    private (set) var gameScore = 0
    
    
    mutating func addCardIndexToClickedCards(index: Int) {
        if !clickedCards.contains(cardChoices[index]) {
            clickedCards += [cardChoices[index]]
        } else {
            if let indexOfCardPressedTwice = clickedCards.firstIndex(of: cardChoices[index]) {
                clickedCards.remove(at: indexOfCardPressedTwice)
                gameScore -= 1
            }
        }
    }
    
    
    mutating func clearClickedCardsArray () {
        clickedCards = []
    }
    
    mutating func punishIfSetExists() {
        if isSetOnScreen() != nil {
            gameScore -= 20
        }
    }
    
    
    mutating func executeCheat(matchingThreeCardsArray: [Card]) {
        clearClickedCardsArray()
        for i in 0..<matchingThreeCardsArray.count {
            let indexOnScreen = cardChoices.firstIndex(of: matchingThreeCardsArray[i])
            chooseCard(at: indexOnScreen!)
            if isMatch { gameScore -= 2 }
        }
    }
    
    
    func isSetOnScreen() -> [Card]? {
        for cardA in cardChoices {
            for cardB in cardChoices {
                for cardC in cardChoices {
                    if cardA != cardB, cardB != cardC, cardC != cardA {
                        if answerForMatch(cardsToBeChecked: [cardA,cardB,cardC]) {
                            return [cardA,cardB,cardC]
                        }
                    }
                }
            }
        }
        return nil
    }
    
    
    func answerForMatch(cardsToBeChecked: [Card]) -> Bool {
        var numbersSet = Set<Int>()
        var shapesSet = Set<String>()
        var shadingsSet = Set<Card.CardShade>()
        var colorsSet = Set<UIColor>()
        cardsToBeChecked.forEach {
            if let cardIndex = cardChoices.firstIndex(of: $0) {
                numbersSet.insert(cardChoices[cardIndex].number.getNumberInt())
                shapesSet.insert(cardChoices[cardIndex].shape.getShapeString())
                shadingsSet.insert(cardChoices[cardIndex].shading)
                colorsSet.insert(cardChoices[cardIndex].color.getUIColor())
            }
        }
        return numbersSet.count != 2 && shapesSet.count != 2 && shadingsSet.count != 2 && colorsSet.count != 2
    }
    
    
    mutating func checkForMatch(index: Int) {
        addCardIndexToClickedCards(index: index)
        if clickedCards.count == 3, answerForMatch(cardsToBeChecked: clickedCards) {
            isMatch = true
            gameScore += 2
        } else {
            gameScore -= 1
        }
    }
    
    
    mutating func replaceCards() {
        for index in clickedCards.indices {
            if cards.count > 0 {
                if let locOfCard = cardChoices.firstIndex(of: clickedCards[index]) {
                    cardChoices[locOfCard] = cards.remove(at: index)
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
        
        //The time of the last click a player made plus another 30 seconds
        let future = Date(timeInterval: 30, since: previousClick)
        
        let fallsBetween = (previousClick ... future).contains(Date())
        
        //If the player hadn't play for 30 seconds he is punished with -3 points
        if !fallsBetween {
            gameScore -= 3
        }
        previousClick = Date()
        
        switch(clickedCards.count) {
            
        case 0,1: addCardIndexToClickedCards(index: index)
            
        case 2: checkForMatch(index: index)
            
        case 3:
            fourCardsSelected(index: index)
            
        default:
            break
        }
    }
    
    
    mutating func addCardsToTheTableCards(number: Int) {
        for _ in 0..<number {
            cardChoices += [cards.remove(at: 0)]
        }
    }
    
    mutating func replaceCardsInTable(number: Int) {
        replaceCards()
        clearClickedCardsArray()
        isMatch = false
    }
    
    func getNumberOfCardsOnScreen () -> Int {
        return cardChoices.count
    }
    
    mutating func handleDealCards () {
        if cards.count >= 3 {
            if isMatch { replaceCardsInTable(number: 3) }
            else {
                punishIfSetExists()
                addCardsToTheTableCards(number: 3)
            }
        }
    }
    
    
    init(numberOfCards: Int) {
        previousClick = Date()
        cards = DeckOfCards.getInitialDeck()
        cards.shuffle()
        for _ in 0..<numberOfCards {
            cardChoices += [cards.remove(at: 0)]
        }
        clearClickedCardsArray()
    }
}


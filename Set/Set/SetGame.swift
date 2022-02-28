//
//  SetGame.swift
//  Set
//
//  Created by Oren Dinur on 14/02/2022.
//

import Foundation
import UIKit

struct SetGame {
    
    var deckCards = Array <SetCard>()
    
    private(set) var lastMatchingCardsIndexes = Array<Int>()
    
    private(set) var clickedCards = Array <SetCard>()
    
    private(set) var modelTableCards = Array <SetCard>()
    
    private var previousClickTime: Date
    
    private(set) var DoClickedCardsMatch = false
    
    private(set) var gameScore = 0
    
    
    mutating func addCardIndexToClickedCards(index: Int) {
        if !clickedCards.contains(modelTableCards[index]) {
            clickedCards += [modelTableCards[index]]
        } else {
            if let indexOfCardPressedTwice = clickedCards.firstIndex(of: modelTableCards[index]) {
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
    
    
    mutating func executeCheat(matchingThreeCardsArray: [SetCard]) {
        clearClickedCardsArray()
        for i in 0..<matchingThreeCardsArray.count {
            let indexOnScreen = modelTableCards.firstIndex(of: matchingThreeCardsArray[i])
            chooseCard(at: indexOnScreen!)
            if DoClickedCardsMatch { gameScore -= 2 }
        }
    }
    
    
    func isSetOnScreen() -> [SetCard]? {
        for cardA in modelTableCards {
            for cardB in modelTableCards {
                for cardC in modelTableCards {
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
    
    
    func answerForMatch(cardsToBeChecked: [SetCard]) -> Bool {
        var numbersSet = Set<Int>()
        var shapesSet = Set<String>()
        var shadingsSet = Set<SetCard.CardShade>()
        var colorsSet = Set<UIColor>()
        cardsToBeChecked.forEach {
            if let cardIndex = modelTableCards.firstIndex(of: $0) {
                numbersSet.insert(modelTableCards[cardIndex].number.getNumberInt())
                shapesSet.insert(modelTableCards[cardIndex].shape.getShapeString())
                shadingsSet.insert(modelTableCards[cardIndex].shading)
                colorsSet.insert(modelTableCards[cardIndex].color.getUIColor())
            }
        }
        return numbersSet.count != 2 && shapesSet.count != 2 && shadingsSet.count != 2 && colorsSet.count != 2
    }
    
    
    mutating func checkForMatch(index: Int) {
        addCardIndexToClickedCards(index: index)
        if clickedCards.count == 3, answerForMatch(cardsToBeChecked: clickedCards) {
            DoClickedCardsMatch = true
            gameScore += 2
        } else {
            gameScore -= 1
        }
    }
    
    
    mutating func replaceCards() {
        for index in clickedCards.indices {
            if deckCards.count > 0 {
                if let locOfCard = modelTableCards.firstIndex(of: clickedCards[index]) {
                    modelTableCards[locOfCard] = deckCards.remove(at: 0)
                }
            } else {
                break
            }
        }
    }
        
    
    mutating func fourCardsSelected(index: Int) {
        if DoClickedCardsMatch {
            if deckCards.count == 0 {
                for i in 0..<clickedCards.count {
                    if let locOfCard = modelTableCards.firstIndex(of: clickedCards[i]) {
                        lastMatchingCardsIndexes += [locOfCard]
                        modelTableCards.remove(at: locOfCard)
                    }
                }
                clearClickedCardsArray()

        } else {
            if !clickedCards.contains(modelTableCards[index]) {
                replaceCards()
                clearClickedCardsArray()
                addCardIndexToClickedCards(index: index)
            } else {
                replaceCards()
                clearClickedCardsArray()
            }
        }
        
    } else {
        clearClickedCardsArray()
        addCardIndexToClickedCards(index: index)
    }
    DoClickedCardsMatch = false
}
    
    
    mutating func chooseCard(at index: Int) {
        
        //The time of the last click a player made plus another 30 seconds
        let future = Date(timeInterval: 30, since: previousClickTime)
        
        let fallsBetween = (previousClickTime ... future).contains(Date())
        
        //If the player hadn't play for 30 seconds he is punished with -3 points
        if !fallsBetween {
            gameScore -= 3
        }
        previousClickTime = Date()
        
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
            modelTableCards += [deckCards.remove(at: 0)]
        }
    }
    
    mutating func replaceCardsInTable(number: Int) {
        replaceCards()
        clearClickedCardsArray()
        DoClickedCardsMatch = false
    }
    
    func getNumberOfCardsOnScreen () -> Int {
        return modelTableCards.count
    }
    
    mutating func handleDealCards () {
        if deckCards.count >= 3 {
            if DoClickedCardsMatch { replaceCardsInTable(number: 3) }
            else {
                punishIfSetExists()
                addCardsToTheTableCards(number: 3)
            }
        }
    }
    
    
    init(numberOfCards: Int) {
        previousClickTime = Date()
        deckCards = DeckOfSetCards.getInitialDeck()
        deckCards.shuffle()
        for _ in 0..<numberOfCards {
            modelTableCards += [deckCards.remove(at: 0)]
        }
        clearClickedCardsArray()
    }
}

extension SetGame {
   static func getInitialCardsNumber() -> Int {
        return 12
    }
    
    static func getAmountOfCardsToAdd() -> Int {
        return 3
    }
    
    static func getAmountOfCardsToDelete() -> Int {
        return 3
    }
}


//
//  ViewController.swift
//  Set
//
//  Created by Oren Dinur on 14/02/2022.
//

import UIKit

class ViewController: UIViewController {
    
    //TODO: Finish "New Game" button, find why 2 buttons are the same
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var numberOfCards = 12
    
    private lazy var game = SetGame(numberOfCards: numberOfCards)
        
    override func viewDidLoad() {
        for index in 0...11 {
            let button = cardButtons[index]
            button.backgroundColor = UIColor.white
            updateButtonsLabel()
        }
    }
    
    @IBAction func resetGame(_ sender: UIButton) {
        numberOfCards = 12
        game = SetGame(numberOfCards: numberOfCards)
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.backgroundColor = UIColor.clear
            button.layer.borderColor = UIColor.clear.cgColor
            button.setTitle("", for: UIControl.State.normal)
            let attributedString = NSAttributedString(string: "")
            button.setAttributedTitle(attributedString, for: .normal)
        }
        
        for index in 0...11 {
            let button = cardButtons[index]
            button.backgroundColor = UIColor.white
            updateButtonsLabel()
        }
        
        updateViewFromModel()
    }
    
    private func getStrokeWidth(card: Card) -> Double{
        switch (card.shading) {
        case "solid": return -15.0
        case "striped": return 0.0
        default: return 10.0
        }
    }
    
    private func getForegroundColor(card: Card) -> UIColor{
        switch (card.shading) {
        case "solid": return card.color.withAlphaComponent(1.0)
        case "striped": return card.color.withAlphaComponent(0.15)
        default: return card.color
        }
    }
    
    private func updateButtonsLabel() {
        for index in 0..<numberOfCards {
            
            let button = cardButtons[index]
            let card = game.cardChoices[index]
            
            let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth : getStrokeWidth(card: card),//Filled-shading
            .foregroundColor: getForegroundColor(card: card),
            .strokeColor : card.color
        ]
            let attributedString = NSAttributedString(string: String(repeating: "\(card.shape)", count: card.number), attributes: attributes)
            
            button.setAttributedTitle(attributedString, for: .normal)
        }
    }

    @IBAction func addThreeCards(_ sender: UIButton) {
        if game.cards.count >= 3 {
            if game.isMatch {
                game.replaceCardsInTable(number: 3)
                updateViewFromModel()
            } else {
                if cardButtons.count >= numberOfCards + 3 {
                game.addCardsToTheTableCards(number: 3)
                for _ in 0...2 {
                    let button = cardButtons[numberOfCards]
                    button.backgroundColor = UIColor.white
                    numberOfCards += 1
                }
            }
            }
        }
        updateButtonsLabel()
    }

    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
//            updateButtonsLabel()
        }
    }
        
//        func drawButton( button: UIButton, width: Double, buttonColor: UIColor, radius: Double) {
//            button.layer.borderWidth = width
//            button.layer.borderColor = UIColor.buttonColor.cgColor
//            button.layer.cornerRadius = radius
//        }
//
        
        
        //TODO: Add the function above
        func updateViewFromModel() {
//            for index in cardButtons.indices {
            for index in 0..<numberOfCards {
                let button = cardButtons[index]
                let card = game.cardChoices[index]
                
                if game.isMatch, game.clickedCards.contains(card) {
                    if game.cards.count > 0 {
                        button.layer.borderWidth = 3.0
                        button.layer.borderColor = UIColor.green.cgColor
                        button.layer.cornerRadius = 8.0
                    } else {
                        button.layer.borderWidth = 0
                        button.layer.borderColor = UIColor.clear.cgColor
                        button.layer.cornerRadius = 0
                    }
                } else {
                    if game.clickedCards.contains(card) {
                        if game.clickedCards.count == 3 {
                            button.layer.borderWidth = 3.0
                            button.layer.borderColor = UIColor.red.cgColor
                            button.layer.cornerRadius = 8.0
                        } else {
                            button.layer.borderWidth = 3.0
                            button.layer.borderColor = UIColor.orange.cgColor
                            button.layer.cornerRadius = 8.0
                        }
                    } else {
                        button.layer.borderWidth = 0
                        button.layer.borderColor = UIColor.clear.cgColor
                        button.layer.cornerRadius = 0
                    }
                }
                button.setTitle("\(game.cardChoices[index].number)\n \(game.cardChoices[index].shape)\n \(game.cardChoices[index].shading)\n " , for: UIControl.State.normal)
            }
            updateButtonsLabel()

        }
    

}


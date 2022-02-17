//
//  ViewController.swift
//  Set
//
//  Created by Oren Dinur on 14/02/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var numberOfCards = 12
    
    private lazy var game = SetGame(numberOfCards: numberOfCards)
    
    override func viewDidLoad() {
        for index in 0..<numberOfCards {
            let button = cardButtons[index]
            button.backgroundColor = UIColor.white
            updateButtonsLabel()
        }
    }
    
    @IBOutlet private weak var scoreCountLabel: UILabel!
    
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
        
        for index in 0..<numberOfCards {
            let button = cardButtons[index]
            button.backgroundColor = UIColor.white
            updateButtonsLabel()
        }
        updateViewFromModel()
    }
    
    private func getStrokeWidth(card: Card) -> Double{
        switch (card.shading) {
        case .solid: return -15.0
        case .striped: return 0.0
        default: return 10.0
        }
    }
    
    private func getForegroundColor(card: Card) -> UIColor{
        switch (card.shading) {
        case .solid: return card.color.getUIColor().withAlphaComponent(1.0)
        case .striped: return card.color.getUIColor().withAlphaComponent(0.15)
        default: return card.color.getUIColor()
        }
    }
    
    private func updateButtonsLabel() {
        for index in 0..<numberOfCards {
            
            let button = cardButtons[index]
            let card = game.cardChoices[index]
            
            let attributes: [NSAttributedString.Key: Any] = [
                .strokeWidth : getStrokeWidth(card: card),//Filled-shading
                .foregroundColor: getForegroundColor(card: card),
                .strokeColor : card.color.getUIColor()
            ]
            let attributedString = NSAttributedString(string: String(repeating: "\(card.shape.getShapeString())", count: card.number.getNumberInt()), attributes: attributes)
            
            button.setAttributedTitle(attributedString, for: .normal)
        }
    }
    
    @IBAction func addThreeCards(_ sender: UIButton) {
        if game.cards.count >= 3 {
            if game.isMatch {
                game.replaceCardsInTable(number: 3)
//                updateViewFromModel()
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
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender), cardNumber < numberOfCards {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    func updateViewFromModel() {
        for index in 0..<numberOfCards {
            let button = cardButtons[index]
            let card = game.cardChoices[index]
            
            if game.isMatch, game.clickedCards.contains(card) {
                if game.cards.count > 0 {
                    button.paintButton(borderWidth: 3.0, borderColor: UIColor.green, cornerRadius: 8.0)
                } else {
                    button.clearPaintButton()
                }
            } else {
                if game.clickedCards.contains(card) {
                    if game.clickedCards.count == 3 {
                        button.paintButton(borderWidth: 3.0, borderColor: UIColor.red, cornerRadius: 8.0)
                    } else {
                        button.paintButton(borderWidth: 3.0, borderColor: UIColor.orange, cornerRadius: 8.0)
                    }
                } else {
                    button.clearPaintButton()
                }
            }
        }
        updateButtonsLabel()
        scoreCountLabel.text = "Score \(game.gameScore)"
    }
}
extension UIButton {
    func paintButton (borderWidth: Double, borderColor: UIColor, cornerRadius: Double) {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = cornerRadius
    }
    
    func clearPaintButton () {
        layer.borderWidth = 0
        layer.borderColor = UIColor.clear.cgColor
        layer.cornerRadius = 0
    }
}

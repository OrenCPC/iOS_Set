//
//  ViewController.swift
//  Set
//
//  Created by Oren Dinur on 14/02/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var gridButtons = [UIButton]()
    
    @IBOutlet weak var gridView: UIView! {
        didSet {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(addThreeCards(_:)))
            swipe.direction = [.down]
            gridView.addGestureRecognizer(swipe)
        }
    }

    lazy var grid = Grid(layout: Grid.Layout.aspectRatio(1), frame: gridView.frame)

    var numberOfCards = 12
    
    var cheatMode = false
    
    private lazy var game = SetGame(numberOfCards: numberOfCards)
    
    @IBOutlet private weak var scoreCountLabel: UILabel!
    
    
    
    func createButtonsInitialDefinitions() {
        grid.cellCount = game.getNumberOfCardsOnScreen()
        gridButtons = []
        for index in 0..<grid.cellCount {
            if let size = grid[index] {
                let button = UIButton(frame: size)
                button.backgroundColor = UIColor.white
                button.layer.borderWidth = 0.5
                button.layer.borderColor = UIColor.black.cgColor
                button.addTarget(self, action: #selector(touchCard), for: .touchUpInside)
                self.gridView.addSubview(button)
                gridButtons += [button]
            }
        }
        updateGridLabel()
        
    }
    
    
    override func viewDidLoad() {
        createButtonsInitialDefinitions()
    }
    
    
    @IBAction func resetGame(_ sender: UIButton) {
        game = SetGame(numberOfCards: 12)
        clearGridView()
        createButtonsInitialDefinitions()
        updateViewFromModel()
    }
    
    
    private func getStrokeWidth(card: Card) -> Double {
        switch (card.shading) {
        case .solid: return -15.0
        case .striped: return 0.0
        default: return 10.0
        }
    }
    
    
    private func getForegroundColor(card: Card) -> UIColor {
        switch (card.shading) {
        case .solid: return card.color.getUIColor().withAlphaComponent(1.0)
        case .striped: return card.color.getUIColor().withAlphaComponent(0.15)
        default: return card.color.getUIColor()
        }
    }
    

    private func updateGridLabel() {
//        if game.cards.count == 0 {
//                    clearGridView()
//                    createButtonsInitialDefinitions()
//        }
        for index in 0..<grid.cellCount {
                let card = game.cardChoices[index]
                let attributes: [NSAttributedString.Key: Any] = [
                    .strokeWidth : getStrokeWidth(card: card),
                    .foregroundColor: getForegroundColor(card: card),
                    .strokeColor : card.color.getUIColor()
                ]
                let attributedString = NSAttributedString(string: String(repeating: "\(card.shape.getShapeString())", count: card.number.getNumberInt()), attributes: attributes)
                
                gridButtons[index].setAttributedTitle(attributedString, for: .normal)
            }
            
        }
    
    func clearGridView() {
        for index in 0..<gridButtons.count {
            gridButtons[index].removeFromSuperview()
        }
        grid.cellCount = 0
    }
    
    
    @IBAction func addThreeCards(_ sender: UIButton) {
        game.handleDealCards()
        clearGridView()
        createButtonsInitialDefinitions()
        updateViewFromModel()
    }


    @objc func touchCard(_ sender: UIButton) {
        if let cardNumber = gridButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction func touchCheat(_ sender: UIButton) {
        if let matchingThreeCardsArray = game.isSetOnScreen() ,!game.isMatch {
            game.executeCheat(matchingThreeCardsArray: matchingThreeCardsArray)
            updateViewFromModel()
        }
    }
    
    

    func updateViewFromModel() {
        clearGridView()
        createButtonsInitialDefinitions()
        for index in 0..<game.getNumberOfCardsOnScreen() {
            let view = gridButtons[index]
            let card = game.cardChoices[index]
            if game.isMatch, game.clickedCards.contains(card) {
//                if game.cards.count > 0 {
                    view.paintButton(borderWidth: 3.0, borderColor: UIColor.green, cornerRadius: 8.0)
//                } else {
//                    view.clearPaintButton()
//                }
            } else if game.clickedCards.contains(card) {
                    if game.clickedCards.count == 3 {
                        view.paintButton(borderWidth: 3.0, borderColor: UIColor.red, cornerRadius: 8.0)
                    } else {
                        view.paintButton(borderWidth: 3.0, borderColor: UIColor.orange, cornerRadius: 8.0)
                    }
            } else {
                view.clearPaintButton()
                }
        }
        
        updateGridLabel()
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
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 0
    }
}

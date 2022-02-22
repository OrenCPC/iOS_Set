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
    
    @IBOutlet weak var gridView: UIView!
//    {
//        didSet {
//            let tap = UITapGestureRecognizer(target: self, action: #selector(tapCard))
//
//        }
//    }
//
//    @objc func tapCard() {
//
//    }

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
                self.view.addSubview(button)
                gridButtons += [button]
            }
        }
        updateGridLabel()
        
    }
    
    func drawTheBeginningOfTheGame() {
        for index in 0..<game.getNumberOfCardsOnScreen() {
            let button = cardButtons[index]
            button.backgroundColor = UIColor.white
            updateButtonsLabel()
        }
    }
    
    func drawTheBeginningOfTheGameWithGrid() {
        grid.cellCount = 12
        for index in 0..<grid.cellCount {
            if let size = grid[index] {
                let button = UIButton(frame: size)
                button.backgroundColor = .white
                button.layer.borderWidth = 2
                button.layer.borderColor = UIColor.black.cgColor
                button.addTarget(self, action: #selector(touchCard), for: .touchUpInside)
                self.view.addSubview(button)
                gridButtons += [button]
                
//                view.removeFromSuperview()
            }
        }
        updateGridLabel()
    }
    
    
    override func viewDidLoad() {
        createButtonsInitialDefinitions()
    }
    
    
    @IBAction func resetGame(_ sender: UIButton) {
//        grid.cellCount = 12
        game = SetGame(numberOfCards: 12)
        clearGridView()
        createButtonsInitialDefinitions()
        updateViewFromModel()
//        for index in 0..<gridButtons.count {
//                    let button = gridButtons[index]
//                    button.backgroundColor = UIColor.clear
//                    button.layer.borderColor = UIColor.clear.cgColor
//                    button.setTitle("", for: UIControl.State.normal)
//                    let attributedString = NSAttributedString(string: "")
//                    button.setAttributedTitle(attributedString, for: .normal)
//                }
//        gridButtons = []
//        drawTheBeginningOfTheGameWithGrid()
//        updateViewFromModel()

        
        
        
        
        
        
        
      //~~~~~~Buttons resetGame:~~~~~~~~
        
        //        numberOfCards = 12
//        game = SetGame(numberOfCards: numberOfCards)
//        for index in cardButtons.indices {
//            let button = cardButtons[index]
//            button.backgroundColor = UIColor.clear
//            button.layer.borderColor = UIColor.clear.cgColor
//            button.setTitle("", for: UIControl.State.normal)
//            let attributedString = NSAttributedString(string: "")
//            button.setAttributedTitle(attributedString, for: .normal)
//        }
//        drawTheBeginningOfTheGame()
//        updateViewFromModel()
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
    
//    for index in 0..<game.getNumberOfCardsOnScreen() {
//        if let size = grid[index] {
//            let view = UIButton(frame: size)
//            view.backgroundColor = .white
//            self.view.addSubview(view)
//        }
//    }   }
    private func updateButtonsLabel() {
        for index in 0..<game.getNumberOfCardsOnScreen() {
            let button = cardButtons[index]
            let card = game.cardChoices[index]
            let attributes: [NSAttributedString.Key: Any] = [
                .strokeWidth : getStrokeWidth(card: card),
                .foregroundColor: getForegroundColor(card: card),
                .strokeColor : card.color.getUIColor()
            ]
            let attributedString = NSAttributedString(string: String(repeating: "\(card.shape.getShapeString())", count: card.number.getNumberInt()), attributes: attributes)
            
            button.setAttributedTitle(attributedString, for: .normal)
        }
    }
    
    private func updateGridLabel() {
        for index in 0..<gridButtons.count {
            
            if let size = grid[index] {
//                let view = UIButton(frame: size)
//                print("view is \(view)")
                
                let card = game.cardChoices[index]
                let attributes: [NSAttributedString.Key: Any] = [
                    .strokeWidth : getStrokeWidth(card: card),
                    .foregroundColor: getForegroundColor(card: card),
                    .strokeColor : card.color.getUIColor()
                ]
                let attributedString = NSAttributedString(string: String(repeating: "\(card.shape.getShapeString())", count: card.number.getNumberInt()), attributes: attributes)
                
                gridButtons[index].setAttributedTitle(attributedString, for: .normal)
//                self.view.addSubview(view)
            }
            
        }
    }
    
    
    /*
     for index in 0..<game.getNumberOfCardsOnScreen() {
         if let size = grid[index] {
             let view = UIButton()
             view.frame = size
             view.backgroundColor = .white
             self.view.addSubview(view)
             gridButtons += [view]
             
//                view.removeFromSuperview()
         }
     }
//        print(gridButtons.count)
     updateGridLabel()
     */
    
    func clearGridView() {
        for index in 0..<gridButtons.count {
//            if let size = grid[index] {
//                let view = UIButton()
//                view.frame = size
//                view.backgroundColor = .white
//                self.view.addSubview(view)
//                gridButtons += [view]
                
            gridButtons[index].removeFromSuperview()
                
            }
        grid.cellCount = 0
        }
    
    
    @IBAction func addThreeCards(_ sender: UIButton) {
//        let numberOfCardsOnScreen = game.getNumberOfCardsOnScreen()
        game.handleDealCards()
        clearGridView()
        print(gridButtons.count)
        createButtonsInitialDefinitions()
//        grid.cellCount = game.getNumberOfCardsOnScreen()
//        gridButtons = []
//        for index in 0..<grid.cellCount {
//            if let size = grid[index] {
//                let view = UIButton(frame: size)
//                view.backgroundColor = UIColor.white
//                view.layer.borderWidth = 2
//                view.layer.borderColor = UIColor.black.cgColor
//                self.view.addSubview(view)
//                gridButtons += [view]
//            }
//        }
//        updateGridLabel()
        
        
        
        
        
        /*
         if let size = grid[index] {
             let view = UIButton(frame: size)
             view.backgroundColor = .white
             self.view.addSubview(view)
             gridButtons += [view]
         
         
         -------
         grid.cellCount = game.getNumberOfCardsOnScreen()
             
             
 //            for index in 0..<game.getNumberOfCardsOnScreen() {
 //                if let size = grid[index] {
 //                    let view = UIButton(frame: size)
 //                    view.backgroundColor = UIColor.white
 //                    self.view.addSubview(view)
 //                }
 //                }
 //
 //            } else {
 //
 //            }
 //            print(grid.cellCount)
         */
//             updateGridLabel()
      
//             updateViewFromModel()
             
         
       
        
    }
        
        ///---------------------///
//        let numberOfCardsOnScreen = game.getNumberOfCardsOnScreen()
//        if cardButtons.count >= numberOfCardsOnScreen + 3 || game.isMatch {
//            game.handleDealCards()
//            if cardButtons.count >= numberOfCardsOnScreen + 3, !game.isMatch {
//                    for index in 0..<game.getNumberOfCardsOnScreen() {
//                        let button = cardButtons[index]
//                        button.backgroundColor = UIColor.white
//                }
//            }
//        }
//        updateButtonsLabel()
//        updateViewFromModel()
    

//    @IBAction func touchCardInGrid(_ sender: UITapGestureRecognizer) {
//        switch sender.state {
//        case .ended:
//            if let cardNumber = gridButtons.firstIndex(of: sender.view?.frame) {
//              print(cardNumber)
//            }
//
//        default: break
//        }
//
//    }
    
    
    
    
    @objc func touchCard(_ sender: UIButton) {
        if let cardNumber = gridButtons.firstIndex(of: sender) {
            print(cardNumber)
            game.chooseCard(at: cardNumber)
            print(game.cardChoices.count)
            updateViewFromModel()
        }
    }
//    @objc func touchCard(_ sender: UIButton) {
//        if let cardNumber = gridButtons.firstIndex(of: sender) {
//            game.chooseCard(at: cardNumber)
//            updateViewFromModel()
//        }
//    }
    
    
    @IBAction func touchCheat(_ sender: UIButton) {
        if let matchingThreeCardsArray = game.isSetOnScreen() ,!game.isMatch {
            game.executeCheat(matchingThreeCardsArray: matchingThreeCardsArray)
            updateViewFromModel()
        }
    }
    
    
//    for index in 0..<game.getNumberOfCardsOnScreen() {
//        if let size = grid[index] {
//            let view = UIButton(frame: size)
//            view.backgroundColor = .white
//            self.view.addSubview(view)
//        }
//    }
//    updateGridLabel()
    
    
    
    
    
    
    
    //            if let size = grid[index] {

    func updateViewFromModel() {
        for index in 0..<game.getNumberOfCardsOnScreen() {
            
//            if let size = grid[index] {
                let view = gridButtons[index]
//                let view = UIButton(frame: size)
//            let button = cardButtons[index]
            let card = game.cardChoices[index]
            if game.isMatch, game.clickedCards.contains(card) {
                if game.cards.count > 0 {
                    view.paintButton(borderWidth: 3.0, borderColor: UIColor.green, cornerRadius: 8.0)
                } else {
                    view.clearPaintButton()
                }
            } else if game.clickedCards.contains(card) {
                    if game.clickedCards.count == 3 {
                        view.paintButton(borderWidth: 3.0, borderColor: UIColor.red, cornerRadius: 8.0)
                    } else {
                        view.paintButton(borderWidth: 3.0, borderColor: UIColor.orange, cornerRadius: 8.0)
                    }
            } else {
                view.clearPaintButton()
                }

//            }
            

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

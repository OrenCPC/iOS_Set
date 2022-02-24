//
//  ViewController.swift
//  Set
//
//  Created by Oren Dinur on 14/02/2022.
//

import UIKit

class SetViewController: UIViewController {
        
    var gridButtons = [UIButton]()
    
    @IBOutlet weak var gridView: UIView! {
        didSet {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(addThreeCards(_:)))
            swipe.direction = [.down]
            gridView.addGestureRecognizer(swipe)
        }
    }

    lazy var grid = Grid(layout: Grid.Layout.aspectRatio(2), frame: gridView.bounds)

    var InitialNumberOfCards = SetGame.getInitialCardsNumber()
        
    private lazy var game = SetGame(numberOfCards: InitialNumberOfCards)
    
    @IBOutlet private weak var scoreCountLabel: UILabel!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.grid.frame = gridView.bounds
        self.redrawGrid()
    }
    
   
    func initiateButtons() {
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
        initiateButtons()
        let rotate = UIRotationGestureRecognizer(target: self, action: #selector(shuffleCards))
        self.view.addGestureRecognizer(rotate)
    }
    
    func redrawGrid() {
        clearGridView()
        initiateButtons()
        updateCardsColorFromModel()
    }
    
    func initiateGameAndGrid() {
        game = SetGame(numberOfCards: InitialNumberOfCards)
        redrawGrid()
    }
    
    
    @IBAction func resetGame(_ sender: UIButton) {
        initiateGameAndGrid()
    }
    
    
    private func getStrokeWidth(card: SetCard) -> Double {
        switch (card.shading) {
        case .solid: return -15.0
        case .striped: return 0.0
        default: return 10.0
        }
    }
    
    
    private func getForegroundColor(card: SetCard) -> UIColor {
        switch (card.shading) {
        case .solid: return card.color.getUIColor().withAlphaComponent(1.0)
        case .striped: return card.color.getUIColor().withAlphaComponent(0.15)
        default: return card.color.getUIColor()
        }
    }
    

    private func updateGridLabel() {
        for index in 0..<grid.cellCount {
                let card = game.modelCards[index]
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
    
    func reframeButtons() {
        let prevAmountOfCardsOnScreen = grid.cellCount
        grid.cellCount = game.getNumberOfCardsOnScreen()
        for index in 0..<prevAmountOfCardsOnScreen {
            if let size = grid[index] {
                gridButtons[index].frame = size
                
            }
        }
        for index in 0..<SetGame.getAmountOfCardsToAdd() {
            if let size = grid[index + prevAmountOfCardsOnScreen] {
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
    
    
    
    
   @objc func shuffleCards() {
       let cardsToBeAdded = game.getNumberOfCardsOnScreen() - InitialNumberOfCards
        initiateGameAndGrid()
        game.addCardsToTheTableCards(number: cardsToBeAdded)
       redrawGrid()

    }
    
    @IBAction func addThreeCards(_ sender: UIButton) {
        game.handleDealCards()
//        redrawGrid()
        reframeButtons()
    }


    @objc func touchCard(_ sender: UIButton) {
        if let cardNumber = gridButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateCardsColorFromModel()
        }
    }
    
    @IBAction func touchCheat(_ sender: UIButton) {
        if let matchingThreeCardsArray = game.isSetOnScreen() ,!game.DoClickedCardsMatch {
            game.executeCheat(matchingThreeCardsArray: matchingThreeCardsArray)
            updateCardsColorFromModel()
        }
    }
    

    func updateCardsColorFromModel() {
        for index in 0..<game.getNumberOfCardsOnScreen() {
            let view = gridButtons[index]
            let card = game.modelCards[index]
            if game.DoClickedCardsMatch, game.clickedCards.contains(card) {
                    view.paintButton(borderWidth: 3.0, borderColor: UIColor.green, cornerRadius: 8.0)
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

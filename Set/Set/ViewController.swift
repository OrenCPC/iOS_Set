//
//  ViewController.swift
//  Set
//
//  Created by Oren Dinur on 14/02/2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    var numberOfCards = 12
    private lazy var game = SetGame(numberOfCards: numberOfCards)
    
    override func viewDidLoad() {
        for index in 0...11 {
            let button = cardButtons[index]
            button.backgroundColor = UIColor.white

        }
    }


    @IBAction func touchCard(_ sender: UIButton) {
//        print("click")
//       print(cardButtons.count)
//        print(game.cards)
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func addThreeCards(_ sender: UIButton) {
    print("Add 3")
    }
}


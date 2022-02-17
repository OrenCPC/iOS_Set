//
//  Card.swift
//  Set
//
//  Created by Oren Dinur on 14/02/2022.
//

import Foundation
import UIKit

struct Card: Hashable, Equatable {
    
    var hashValue: Int { return identifier }
    
    let number: Int
    let shape: String
    let shading : String
    let color : UIColor
    
//    var isMatched = false
//    var isClicked = false
    
    //change to private
     var identifier: Int
    
    private static var identifierFactory = 0

        
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
   private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(number: Int, shape: String, shading:String, color: UIColor) {
        self.identifier = Card.getUniqueIdentifier()
        self.number = number
        self.shape = shape
        self.shading = shading
        self.color = color
    }
}

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
    
    private(set) var number: Int
    private(set) var shape: String
    private(set) var shading : String
    private(set) var color : UIColor
    
//    var isMatched = false
//    var isClicked = false
    
    private static var identifierFactory = 0

   private var identifier: Int
        
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

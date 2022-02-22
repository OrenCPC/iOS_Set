//
//  Card.swift
//  Set
//
//  Created by Oren Dinur on 14/02/2022.
//
//TODO: delete the CustomStringConvertible if not used 
import Foundation
import UIKit

struct Card: Hashable, Equatable, CustomStringConvertible {
    
    var description: String { return "\(color)\(shading)\(shape)\(number)"}
    
    
    var hashValue: Int { return identifier }
    
    enum CardNumber: CaseIterable, CustomStringConvertible {
        var description: String { return String(getNumberInt()) }
        
        case first, second, third
        
        func getNumberInt() -> Int {
            switch self {
            case .first:
                return 1
            case .second:
                return 2
            case .third:
                return 3
            }
        }
    }
    
    enum CardShape: CaseIterable, CustomStringConvertible {
                
        case circle, triangle, square
        
        func getShapeString() -> String {
            switch self {
            case .circle:
                return "●"
            case .triangle:
                return "▲"
            case .square:
                return "■"
            }
        }
        var description: String { return getShapeString() }

    }
    
    enum CardShade: CaseIterable, CustomStringConvertible {
        var description: String {
            switch(self) {
            case .solid: return "solid"
            case.striped: return "striped"
            case.open: return "open"
            }
        }
        
        case solid, striped, open
    }
    
    enum CardColor: CaseIterable, CustomStringConvertible {
        var description: String {
            switch(self) {
            case .red: return "red"
            case.green: return "green"
            case.purple: return "purple"
            }
        }
        
        case red, green, purple
        
        func getUIColor() -> UIColor {
            switch self {
            case .red:
                return UIColor.red
            case .green:
                return UIColor.green
            case .purple:
                return UIColor.purple
            }
        }
    }
    
    
    let number: CardNumber
    
    let shape: CardShape
    
    let shading : CardShade
    
    let color : CardColor
    
    private var identifier: Int
    
    private static var identifierFactory = 0

        
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
   private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(number: CardNumber, shape: CardShape, shading: CardShade, color: CardColor) {
        self.identifier = Card.getUniqueIdentifier()
        self.number = number
        self.shape = shape
        self.shading = shading
        self.color = color
    }
}

//
//  Card.swift
//  Set
//
//  Created by Juan Castillo on 2/24/19.
//  Copyright © 2019 Juan Castillo. All rights reserved.
//

import Foundation
import UIKit

struct Card {
    var isSelected = false
    var color: Color = Color.green
    var shape: Shape = Shape.oval
    var number: Number = Number.one
    var fill: Fill = Fill.open
    private var identifier: Int
    static var identifierFactory = 0
    
    enum Shape{
        case diamond
        case squiggle
        case oval
        
        static var all: [Shape] {
            return [.diamond, .squiggle, .oval]
        }
    }
    
    enum Color{
        
        case red
        case green
        case purple
        
        static var all: [Color]{
            return [.red, .purple, .green]
        }
    }
    
    enum Fill {
        case solid
        case stripped
        case open
        
        static var all: [Fill]{
            return [.open, .stripped, .solid]
        }
    }
    
    enum Number:Int {
        case one = 1
        case two = 2
        case three = 3
        
        static var all: [Number]{
            return [.one,.two,.three]
        }
    }
    
    static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init(shape: Shape, color: Color, fill: Fill, number: Number) {
        self.shape = shape
        self.color = color
        self.fill = fill
        self.number = number
        identifier = Card.getUniqueIdentifier()
    }
}

extension Card: Equatable {
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return (lhs.color == rhs.color) &&
        (lhs.shape == rhs.shape) &&
        (lhs.fill == rhs.fill) &&
        (lhs.number == rhs.number)
    }
}

//
//  Set.swift
//  Set
//
//  Created by Juan Castillo on 2/24/19.
//  Copyright © 2019 Juan Castillo. All rights reserved.
//

import Foundation
class Set {
    var score = 0
    var deck = [Card]()
    var dealt = [Card]()
    var selected = [Card]()
    var matched: [Card] = []
    
    func createDeck(){
        deck = [Card]()
        for color in 0...2 {
            for fill in 0...2{
                for shape in 0...2 {
                    for number in 0...2{
                        deck.append(Card(shape: Card.Shape.all[shape], color: Card.Color.all[color], fill: Card.Fill.all[fill], number: Card.Number.all[number]))
                    }
                }
            }
        }
        print(deck)
        deck.shuffle()
    }
    
    // Deal cards 
    func dealCards(inTotalOf: Int){
        for _ in 0..<inTotalOf {
            if !deck.isEmpty {
                let card = deck.removeLast()
                dealt.append(card)
            }
        }
    }
    
    init() {
        createDeck()
    }
}

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
        deck.shuffle()
    }
    
    // Deal a given number of cards
    func dealCards(inTotalOf: Int){
        for _ in 0..<inTotalOf {
            if !deck.isEmpty {
                let card = deck.removeLast()
                dealt.append(card)
            }
        }
    }
    
    //Select a given card
    func selectCard(at index: Int) {
        //Allow deselecting cards as long as three are not selected
        if selected.count <= 1 {
            // TODO implement the score
            if let deselect = selected.index(of : dealt[index]){
                selected.remove(at: deselect)
                dealt[index].isSelected = false
            } else{
                dealt[index].isSelected = true
                selected.append(dealt[index])
            }
        } else {
            dealt[index].isSelected = true
            selected.append(dealt[index])
            
            let allItemsEqual = selected.dropLast().allSatisfy{$0 == selected.last}
            print(allItemsEqual)
            
            for index in selected.indices {
                selected[index].isSelected = false
            }
            selected.removeAll()
        }
        
    }
    
    init() {
        createDeck()
    }
}

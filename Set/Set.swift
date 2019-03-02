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
    var isSelectedSet = false
    
    //Create the 81 different cards
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
        // shuffle them just for good measure
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
    
    func checkSelected() {
        if !(selected.count < 3){
            isSelectedSet = selected.dropLast().allSatisfy{$0 == selected.last}
            
            // if the selected cards are a set
            if(isSelectedSet){
                score += 3
                matched.append(contentsOf: selected)
                dealCards(inTotalOf: 3)
            } else {
                score -= 4
            }
            
            // After checking for set, deselect all the cards
            for index in 0..<dealt.count {
                if selected.contains(dealt[index]) {
                    dealt[index].isSelected = false
                }
            }
            // Clean the selected array
            selected.removeAll()
            // TODO move the selected cards to the matches array.
        }
    }
    
    //Select a given card
    func selectCard(at index: Int) {
        assert(dealt.indices.contains(index),"Set.chooseCard(at:\(index): chosen index isns not in the cards")
        //Allow deselecting cards as long as three are not selected
        if selected.count <= 1 {
            // TODO implement the score
            if let deselect = selected.index(of : dealt[index]){
                selected.remove(at: deselect)
                score -= 1
                dealt[index].isSelected = false
            } else{
                dealt[index].isSelected = true
                selected.append(dealt[index])
            }
        } else {
            dealt[index].isSelected = true
            selected.append(dealt[index])
            
           checkSelected()
        }
        
    }
    
    init() {
        createDeck()
    }
}

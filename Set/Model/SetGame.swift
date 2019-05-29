//
//  Set.swift
//  Set
//
//  Created by Juan Castillo on 2/24/19.
//  Copyright © 2019 Juan Castillo. All rights reserved.
//

import Foundation
class SetGame {
    var score = 0
    var deck = [Card]()
    var dealt = [Card]()
    var selected = [Card]()
    
    //Create the 81 different cards
    func createDeck(){
        deck = [Card]()
        for color in 0...2 {
            for fill in 0...2{
                for shape in 0...2 {
                    for number in 0...2{
                        deck.append(Card(shape: Card.Shape.all[shape], color: Card.Color.all[color], fill: Card.Shading.all[fill], number: Card.Number.all[number]))
                    }
                }
            }
        }
        // shuffle them just for good measure
//        deck.shuffle()
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
    
    // Shuffles the dealt cards 
    func shuffle(){
        dealt.shuffle()
    }
    

    func checkSelected() -> Bool {
        guard selected.count == 3 else {return false}
        let isSet = checkIfMatch()
        
        if isSet {
            removeSelectedFromBoard()
            score += 3
            dealCards(inTotalOf: 3)
        } else {
            score -= 4
            selected.removeAll()
        }
        
        return isSet
    }
    
    private func removeSelectedFromBoard(){
        for card in selected {
            dealt.removeAll { $0 == card
            }
        }
        selected.removeAll()
    }
    
    private func checkIfMatch() -> Bool {
        var numbers = Set<Card.Number>()
        var shapes = Set<Card.Shape>()
        var colors = Set<Card.Color>()
        var fillings = Set<Card.Shading>()
        
        for card in selected {
            numbers.insert(card.number); shapes.insert(card.shape); colors.insert(card.color); fillings.insert(card.fill)
        }
        let isSet = (numbers.count == 1 || numbers.count == 3) && (shapes.count == 1 || shapes.count == 3) && (colors.count == 1 || colors.count == 3) && (fillings.count == 1 || fillings.count == 3)
        return isSet
    }
    
    //Select a given card
    //Add the card at the specified index into the selected array
    func selectCard(at index: Int) {
        assert(dealt.indices.contains(index),"Set.chooseCard(at:\(index): chosen index is not in the cards")
        
        dealt[index].isSelected = true
        let selectedCard = dealt[index]
        
        selected.append(selectedCard)
    }
    
    func deselectCard(at index: Int){
        assert(dealt.indices.contains(index),"Set.chooseCard(at:\(index): chosen index is not in the cards")
        
        score -= 1
        dealt[index].isSelected = false
        selected.removeAll { $0 == dealt[index]
        }
    }
    
    init() {
        createDeck()
    }
}

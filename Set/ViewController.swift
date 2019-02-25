//
//  ViewController.swift
//  Set
//
//  Created by Juan Castillo on 2/24/19.
//  Copyright © 2019 Juan Castillo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Set()

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var setIndicator: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        
    }
    @IBAction func dealThreeCards(_ sender: UIButton) {
        if(game.dealt.count + 3) <= cardButtons.count {
            // TODO deal 3 cards
            // TODO update view
        }
    }
    @IBAction func restart(_ sender: UIButton) {
    }
    
    func face(for card: Card) -> NSMutableAttributedString {
        
        var attributes: [NSAttributedString.Key: Any] = [:]
        var string = ""
        var attributedString = NSMutableAttributedString(string: string, attributes: attributes)
        
        if card.color == Card.Color.red {
            attributes[.foregroundColor] = UIColor.red
        } else if card.color == Card.Color.green{
            attributes[.foregroundColor] = UIColor.green
        } else {
            attributes[.foregroundColor] = UIColor.purple
        }
        
        if card.shape == Card.Shape.circle {
            string = Card.Shape.circle.rawValue
            attributedString.mutableString.setString(string)
        } else if card.shape == Card.Shape.rectangle{
            string = Card.Shape.rectangle.rawValue
            attributedString.mutableString.setString(string)
        } else {
            string = Card.Shape.triangle.rawValue
            attributedString.mutableString.setString(string)
        }
        
        if card.number == Card.Number.two {
            string += string
            attributedString.mutableString.setString(string)
        } else if card.number == Card.Number.three {
            string = string + string + string
            attributedString.mutableString.setString(string)
        }
        
        if card.fill == Card.Fill.open {
            attributes[.strokeWidth] = 20.0
        } else if card.fill == Card.Fill.solid {
            attributes[.strokeWidth] = 5.0
        }
        
        attributedString = NSMutableAttributedString(string: string, attributes: attributes)
        
        return attributedString
    }
    
    func updateViewFromModel(){
        for index in 0...11 {
            let button = cardButtons[index]
            let card = game.dealt.removeLast()
            if card.isSelected {
                
            } else {
                button.setAttributedTitle(face(for: card), for: .normal)
            }
        }
    }
    
    func newGame(){
        for button in cardButtons.indices {
            if cardButtons[button].currentAttributedTitle != nil {
                cardButtons[button].setAttributedTitle(nil, for: .normal)
                cardButtons[button].isSelected = false
                cardButtons[button].layer.borderWidth = 0.0
            }
        }
        
        game = Set()
        game.dealCards(inTotalOf: 12)
        updateViewFromModel()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        newGame()
    }


}


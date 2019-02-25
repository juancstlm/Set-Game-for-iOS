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
        if let cardNumber = cardButtons.index(of: sender){
            print("cardNumber = \(cardNumber)")
            game.selectCard(at: cardNumber)
            updateViewFromModel()
        }else {
            print("Chosen Card was not in cardButtons")
        }
    }
    @IBAction func dealThreeCards(_ sender: UIButton) {
        if(game.dealt.count + 3) <= cardButtons.count {
            game.dealCards(inTotalOf: 3)
            updateViewFromModel()
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
        
        if card.fill == Card.Fill.solid {
            attributes[.strokeWidth] = -1
        } else if card.fill == Card.Fill.stripped {
            attributes[.strokeWidth] = -1
            if card.color == Card.Color.red {
                attributes[.foregroundColor] = UIColor.red.withAlphaComponent(0.15)
            } else if card.color == Card.Color.green{
                attributes[.foregroundColor] = UIColor.green.withAlphaComponent(0.35)
            } else {
                attributes[.foregroundColor] = UIColor.purple.withAlphaComponent(0.35)
            }
        } else {
            attributes[.strokeWidth] = 5
        }
        
        attributedString = NSMutableAttributedString(string: string, attributes: attributes)
        
        return attributedString
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            // check the dealt pile is not empty
            print(index)
            if index < game.dealt.count {
                let card = game.dealt[index]
                if card.isSelected {
                    button.layer.borderWidth = 4.0
                    button.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                } else {
                    button.setAttributedTitle(face(for: card), for: .normal)
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    button.layer.borderWidth = 0
                }
            } else  {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
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


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
    
    @IBOutlet weak var scoreLabel: UILabel! {didSet{updateScoreLabel()}}
    @IBOutlet weak var setIndicator: UILabel! {didSet{updateSetIndicatorLabel()}}
    
    private(set) var isSet = false {didSet{updateSetIndicatorLabel()}}
    private(set) var score = 0 {didSet{updateScoreLabel()}}
    
    @IBOutlet weak var cardView: CardView!
    @IBOutlet weak var gridView: GridView!
    
    @IBAction func dealThreeCards(_ sender: UIButton) {
        // TDODO
    }
    
    @IBAction func restart(_ sender: UIButton) {
        newGame()
    }
    
    private func updateSetIndicatorLabel () {
        if(game.isSelectedSet){
            let attributedString = NSAttributedString(string: "Set Found")
            print("We found a set boysss!!!")
            setIndicator.attributedText = attributedString
        } else {
            let attributedString = NSAttributedString(string: "Not a Set")
            print("not a set")
            setIndicator.attributedText = attributedString
        }
    }
    
    private func updateScoreLabel(){
        let attributedString = NSAttributedString(string: "Score \(score)")
        scoreLabel.attributedText = attributedString
    }
    
    func updateViewFromModel(){
        isSet = game.isSelectedSet
        score = game.score
        
        cardView.drawPips(for: game.dealt[0], size: 12, orientation: Orientation.vertical)
        view.addSubview(createCardView(card: game.dealt[1], index: 2))
        
//        for index in cardButtons.indices {
//            let button = cardButtons[index]
//            // check the dealt pile is not empty
//            print(index)
//            if index < game.dealt.count {
//                let card = game.dealt[index]
//                if card.isSelected {
//                    button.layer.borderWidth = 4.0
//                    button.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
//                } else {
//                    button.setAttributedTitle(face(for: card), for: .normal)
//                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//                    button.layer.borderWidth = 0
//                }
//            } else  {
//                button.setTitle("", for: UIControl.State.normal)
//                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
//            }
//
//        }
        view.setNeedsDisplay()
        view.setNeedsLayout()
    }
    
    func createCardView(card: Card, index: Int) -> UIView {
        let cardV = CardView()
        cardV.tag = index
        
        let orientation: Orientation = .vertical
        
        var cardSize: CGFloat
        if orientation == .vertical {
            cardSize = view.bounds.width
        }
        else {
            //int division rounded up to find rows
            cardSize = view.bounds.height
        }
        
        cardV.drawPips(for: card, size: cardSize, orientation: orientation)
        
        return cardV
    }
    
    func newGame(){
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


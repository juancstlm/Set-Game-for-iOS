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
    @IBAction func dealCards(_ sender: UISwipeGestureRecognizer) {
        // Deal 3 Cards
    }
    @IBAction func shuffleDeck(_ sender: UIRotationGestureRecognizer) {
        game.shuffle()
        updateViewFromModel()
    }
    
    @IBAction func restart(_ sender: UIButton) {
        newGame()
    }
    
    override func viewDidLayoutSubviews() {
        updateViewFromModel()
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
//        gridView.addSubview(createCardView(card: game.dealt[1], index: 2))
        let otherCard = createCardView(card: game.dealt[1], index: 0)
        self.view.addSubview(otherCard)
        
        gridView.setNeedsDisplay()
        gridView.setNeedsLayout()
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
        
        if card.isSelected {
            for view in cardV.subviews{
                view.backgroundColor = UIColor.orange
            }
        }
        
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


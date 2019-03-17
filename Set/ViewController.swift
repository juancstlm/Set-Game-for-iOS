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
    private var initalDealtCards = 12
    
    @IBOutlet weak var scoreLabel: UILabel! {didSet{updateScoreLabel()}}
    @IBOutlet weak var setIndicator: UILabel! {didSet{updateSetIndicatorLabel()}}
    
    private(set) var isSet = false {didSet{updateSetIndicatorLabel()}}
    private(set) var score = 0 {didSet{updateScoreLabel()}}
    
    // Adds a new Collection View to the view
    let newCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collection.backgroundColor = UIColor.clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        
        return collection
    }()
    
    let cellId = "cellId"
    
    func setupCollection(){
        newCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newCollection.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        newCollection.heightAnchor.constraint(equalToConstant: view.frame.height - 180).isActive = true
        newCollection.widthAnchor.constraint(equalToConstant: view.frame.width - 16).isActive = true
    }
    
    
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
        game.dealCards(inTotalOf: initalDealtCards)
        updateViewFromModel()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        newGame()
        
        newCollection.delegate = self
        newCollection.dataSource = self
        
        newCollection.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        view.addSubview(newCollection)
        
        setupCollection()
        
        updateViewFromModel()
    }
    
    func calculateWidthOfCard()-> Int {
        let width = 50
        return width
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.dealt.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newCollection.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CollectionViewCell
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 5
        cell.cardVi.drawPips(for: game.dealt[indexPath.item], size: 16, orientation: .vertical) 
        return cell
    }
    
    // THIS IS TO CUSTOMIZE THE CELLS
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
}

//
//  ViewController.swift
//  Set
//
//  Created by Juan Castillo on 2/24/19.
//  Copyright © 2019 Juan Castillo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = SetGame()
    private var initalDealtCards = 12
    private var setFoundString = "Set!"
    private var notASetString = "Not a set!"
    
    @IBOutlet weak var scoreLabel: UILabel! {didSet{updateScoreLabel()}}
    
    @IBOutlet weak var topBar: UIStackView!
    
    @IBOutlet weak var dealButton: UIButton!
    
    private(set) var isSet = false
    private(set) var score = 0 {didSet{updateScoreLabel()}}
    
    // Adds a new Collection View to the view
    let newCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collection.backgroundColor = UIColor.clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        collection.allowsMultipleSelection = true
        
        return collection
    }()
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // .default
    }
    
    let cellId = "cellId"
    
    func setupCollection(){
        newCollection.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 8).isActive = true
        newCollection.bottomAnchor.constraint(equalTo: dealButton.topAnchor, constant: -8).isActive = true
        newCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        newCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }
    
    
    @IBAction func dealThreeCards(_ sender: UIButton) {
        game.dealCards(inTotalOf: 3)
        DispatchQueue.main.async(execute: {
            self.newCollection.reloadData()
        })
        updateViewFromModel()
    }
    
    @IBAction func dealCards(_ sender: UISwipeGestureRecognizer) {
        // Deal 3 Cards
    }
    @IBAction func shuffleDeck(_ sender: UIRotationGestureRecognizer) {
        shuffleDealtCards()
    }
    
    @IBAction func shuffleDeckButton(_ sender: UIButton) {
        shuffleDealtCards()
    }
    func shuffleDealtCards(){
        game.shuffle()
        updateViewFromModel()
    }
    
    @IBAction func restart(_ sender: UIButton) {
        newGame()
    }
    
    private func updateScoreLabel(){
        let attributedString = NSAttributedString(string: "Score: \(score)")
        scoreLabel.attributedText = attributedString
    }
    
    func updateViewFromModel(){
        DispatchQueue.main.async(execute: {
            self.newCollection.reloadData()
        })
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
        game = SetGame()
        game.dealCards(inTotalOf: initalDealtCards)
        updateViewFromModel()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        newGame()
        
        newCollection.delegate = self
        newCollection.dataSource = self
        
        // set up score label
        scoreLabel.widthAnchor.constraint(equalToConstant: topBar.bounds.width / 2).isActive = true
        scoreLabel.heightAnchor.constraint(equalToConstant: topBar.bounds.height).isActive = true
//        topBar.heightAnchor.constraint(equalToConstant: view.bounds.height/5).isActive = true
        
        newCollection.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        view.addSubview(newCollection)
        
        
        
        setupCollection()
        
        updateViewFromModel()
    }
//
//    func calculateHeightOfCard()-> CGSize{
//        let count = game.dealt.count
//        let ratio = CGFloat( 0.75)
//        var height = CGFloat()
//        height = (newCollection.frame.height / 4 ) - 10.0
//
//        if count <= 12 {
//            height = (newCollection.frame.height / 4 ) - 10.0
//            return CGSize(width: height * ratio, height: height)
//        }
//        return CGSize(width: 50, height: 70)
//    }
//
    func calculatePipSize()-> Int{
        if game.dealt.count == 12 {
            return 200
        } else {
            return 16
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.dealt.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newCollection.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CollectionViewCell
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 8
        
        if cell.isSelected {
            cell.layer.borderColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            cell.layer.borderWidth = 4
        } else {
             cell.layer.borderWidth = 0
        }
        cell.cardView.drawPips(for: game.dealt[indexPath.item], size: CGFloat(calculatePipSize()), orientation: .vertical)
        return cell
    }
    
    
    // THIS IS TO CUSTOMIZE THE CELLS
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        var rows: CGFloat = 0.0
        
        let cvFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        switch collectionView.numberOfItems(inSection: 0) {
            
        case 0...12:
            rows = 4
            cvFlowLayout.minimumInteritemSpacing = 9.0
            cvFlowLayout.minimumLineSpacing = 8.0
        case 13...30:
            rows = 7.0
            cvFlowLayout.minimumInteritemSpacing = 9.0
            cvFlowLayout.minimumLineSpacing = 8.0
        case 31...52:
            rows = 8.0
            cvFlowLayout.minimumInteritemSpacing = 5.0
            cvFlowLayout.minimumLineSpacing = 4.0
        case 53...81:
            rows = 9.0
            cvFlowLayout.minimumInteritemSpacing = 3.0
            cvFlowLayout.minimumLineSpacing = 3.5
        default:
            rows = 4
        }
        
        let height = (collectionView.bounds.height - (rows - 1) * cvFlowLayout.minimumInteritemSpacing) / rows
        let width = height * 0.74
        
        
        return CGSize(width: width, height: height)
        //        return UICollectionViewFlowLayout.automaticSize
        //        return CGSize(width: collectionView.frame.width -10, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        print("should deselect item at \(indexPath.item)")
        return true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // select the card in the model
        game.selectCard(at: indexPath.item)
        // show the card as being selected
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.layer.borderColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            cell.layer.borderWidth = 4
        }
        
        print("selected cell \(indexPath.item)")
        
        let numSelected = collectionView.indexPathsForSelectedItems?.count
        
        
        if numSelected == 3 {
            print("3 cards selected")
            
            // check the game model if the 3 cards make a set
            game.checkSelected()
            
            score = game.score
            
            collectionView.deselectAllItems(animated: true)
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("deselect cell at \(indexPath.item)")
        // deselect the card from the game model
        game.deselectCard(at: indexPath.item)
        
        score = game.score
        if let cell = collectionView.cellForItem(at: indexPath) {
             cell.layer.borderWidth = 0
        }
    }
    
    // allows selection of up to 3 items
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let shouldSelect = collectionView.indexPathsForSelectedItems!.count < 3
        return shouldSelect
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
}

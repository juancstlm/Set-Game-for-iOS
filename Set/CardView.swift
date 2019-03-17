//
//  CardView.swift
//  Set
//
//  Created by Juan Castillo on 3/13/19.
//  Copyright © 2019 Juan Castillo. All rights reserved.
//

import UIKit

class CardView: UIStackView {
    
    func drawPips(for card: Card, size: CGFloat, orientation: Orientation){
        for view in subviews{
            view.removeFromSuperview()
        }
        distribution = .fillEqually
        alignment = .center
//        translatesAutoresizingMaskIntoConstraints = false
        
        // add the appropriate number of symbols
        for _ in 1...card.number.rawValue{
            let shapeView = ShapeView()
            shapeView.translatesAutoresizingMaskIntoConstraints = false
            
            // set the properties
            shapeView.shape = card.shape
            shapeView.fill = card.fill
            switch card.color{
            case .green:
                shapeView.color = UIColor.green
            case .purple:
                shapeView.color = UIColor.purple
            case .red:
                shapeView.color = UIColor.red
            }
            
            shapeView.backgroundColor = .clear
            addArrangedSubview(shapeView)
            
            if orientation == .horizontal {
                axis = .horizontal
                shapeView.orientation = .vertical
                shapeView.heightAnchor.constraint(equalToConstant: size ).isActive = true
            }
            else {
                axis = .vertical
                shapeView.orientation = .horizontal
                shapeView.widthAnchor.constraint(equalToConstant: size ).isActive = true
            }
        }
        setNeedsDisplay()
        setNeedsLayout()
    }
    
}

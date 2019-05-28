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
        distribution = .fillProportionally
        alignment = .center
        spacing = 5
        translatesAutoresizingMaskIntoConstraints = false
        
        // add the appropriate number of symbols
        for _ in 1...card.number.rawValue{
            let shapeView = ShapeView()
            shapeView.translatesAutoresizingMaskIntoConstraints = false
            
            // set the properties
            shapeView.shape = card.shape
            shapeView.fill = card.fill
            switch card.color{
            case .green:
                shapeView.color = #colorLiteral(red: 0.3803921569, green: 0.8431372549, blue: 0.3803921569, alpha: 1)
            case .purple:
                shapeView.color = #colorLiteral(red: 0.3764705882, green: 0.3411764706, blue: 0.8431372549, alpha: 1)
            case .red:
                shapeView.color = #colorLiteral(red: 0.9979028106, green: 0, blue: 0.5254169703, alpha: 1)
            }
            
            shapeView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            addArrangedSubview(shapeView)
            
            if orientation == .horizontal {
                axis = .horizontal
                shapeView.orientation = .vertical
                shapeView.heightAnchor.constraint(equalToConstant: 1 ).isActive = true
            }
            else {
                axis = .vertical
                shapeView.orientation = .horizontal
//                shapeView.widthAnchor.constraint(equalToConstant: size ).isActive = true
                shapeView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
                shapeView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            }
        }
        setNeedsDisplay()
        setNeedsLayout()
    }
}

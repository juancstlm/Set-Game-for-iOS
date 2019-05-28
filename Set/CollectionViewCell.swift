//
//  CollectionViewCell.swift
//  Set
//
//  Created by Juan Castillo on 3/17/19.
//  Copyright © 2019 Juan Castillo. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 8
        setUpView()
    }
    
    let cardView: CardView = {
        let v = CardView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleToFill
        v.clipsToBounds = true
        v.layer.cornerRadius = 8
        
        return v
    }()
    
    func setUpView(){
        addSubview(cardView)

        cardView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        cardView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        cardView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7).isActive = true
        cardView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        let leftConstraint = contentView.leftAnchor.constraint(equalTo: leftAnchor)
        let rightConstraint = contentView.rightAnchor.constraint(equalTo: rightAnchor)
        let topConstraint = contentView.topAnchor.constraint(equalTo: topAnchor)
        let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UICollectionView {
    
    func deselectAllItems(animated: Bool) {
        guard let selectedItems = indexPathsForSelectedItems else { return }
        for indexPath in selectedItems { deselectItem(at: indexPath, animated: animated) }
    }
}

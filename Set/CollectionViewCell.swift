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
        
        setUpView()
    }
    
    let cardVi: CardView = {
        let v = CardView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleToFill
        v.clipsToBounds = true
        v.layer.cornerRadius = 10
        
        return v
    }()
    
    func setUpView(){
        addSubview(cardVi)

        cardVi.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        cardVi.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        cardVi.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        cardVi.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        let leftConstraint = contentView.leftAnchor.constraint(equalTo: leftAnchor)
        let rightConstraint = contentView.rightAnchor.constraint(equalTo: rightAnchor)
        let topConstraint = contentView.topAnchor.constraint(equalTo: topAnchor)
        let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool{
        didSet{
            if self.isSelected
            {
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.contentView.layer.borderWidth = 2
                self.contentView.layer.borderColor = UIColor.orange.cgColor
                self.contentView.layer.cornerRadius = 10
                
//                self.tickImageView.isHidden = false
            }
            else
            {
                self.transform = CGAffineTransform.identity
                self.contentView.layer.borderColor = UIColor.clear.cgColor
//                self.tickImageView.isHidden = true
            }
        }
    }
}

extension UICollectionView {
    
    func deselectAllItems(animated: Bool) {
        guard let selectedItems = indexPathsForSelectedItems else { return }
        for indexPath in selectedItems { deselectItem(at: indexPath, animated: animated) }
    }
}

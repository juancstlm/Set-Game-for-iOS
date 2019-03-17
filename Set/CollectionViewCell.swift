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
        v.backgroundColor = UIColor.gray
        return v
    }()
    
    func setUpView(){
        addSubview(cardVi)
        
        cardVi.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        cardVi.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        cardVi.heightAnchor.constraint(equalToConstant: 100).isActive = true
        cardVi.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

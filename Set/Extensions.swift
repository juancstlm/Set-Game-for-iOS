//
//  Extensions.swift
//  Set
//
//  Created by Juan Castillo on 5/28/19.
//  Copyright © 2019 Juan Castillo. All rights reserved.
//

import Foundation
import UIKit


extension UICollectionView {
    
    func deselectAllItems(animated: Bool) {
        guard let selectedItems = indexPathsForSelectedItems else { return }
        for indexPath in selectedItems { deselectItem(at: indexPath, animated: animated) }
        self.reloadData()
    }
}

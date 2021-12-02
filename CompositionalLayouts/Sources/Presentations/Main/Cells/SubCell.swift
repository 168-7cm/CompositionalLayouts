//
//  SubCell.swift
//  CompositionalLayouts
//
//  Created by kou yamamoto on 2021/12/02.
//

import UIKit

final class SubCell: UICollectionViewCell {
    
    @IBOutlet private weak var shopNameLabel: UILabel!
    @IBOutlet private weak var shopLocationLabel: UILabel!
    
    func configure(shop: Shop) {
        shopNameLabel.text = shop.name
        shopLocationLabel.text = shop.location
    }
}

//
//  Header.swift
//  CompositionalLayouts
//
//  Created by kou yamamoto on 2021/11/30.
//

import UIKit

final class HeaderView: UICollectionReusableView {

    @IBOutlet private weak var titleLabel: UILabel!

    func configure(str: String) {
        titleLabel.text = str
    }
}

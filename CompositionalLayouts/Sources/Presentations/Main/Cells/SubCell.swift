//
//  SubCell.swift
//  CompositionalLayouts
//
//  Created by kou yamamoto on 2021/12/02.
//

import UIKit
import RxSwift
import RxGesture

final class SubCell: UICollectionViewCell {

    let disposeBag = DisposeBag()
    
    @IBOutlet private weak var shopNameLabel: UILabel!
    @IBOutlet private weak var shopLocationLabel: UILabel!
    @IBOutlet fileprivate weak var shopImageView: UIImageView!

    func configure(shop: Shop) {
        shopNameLabel.text = shop.name
        shopLocationLabel.text = shop.location
    }
}

extension Reactive where Base: SubCell {

    var tappedImageView: TapControlEvent {
        return base.shopImageView.rx.tapGesture()
    }
}

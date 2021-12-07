//
//  MainCell.swift
//  CompositionalLayouts
//
//  Created by kou yamamoto on 2021/11/30.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

final class MainCell: UICollectionViewCell {

    let disposeBag = DisposeBag()
    
    @IBOutlet private weak var townNameLabel: UILabel!
    @IBOutlet private weak var townPopulationLabel: UILabel!
    @IBOutlet fileprivate weak var townImageView: UIImageView!

    func configure(town: Town) {
        townNameLabel.text = town.name
        townPopulationLabel.text = town.pupulation
        townImageView.image = Asset.rakuten.image
    }
}

extension Reactive where Base: MainCell {

    var tappedImageView: TapControlEvent {
        return base.townImageView.rx.tapGesture()
    }
}

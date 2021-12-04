//
//  FooterView.swift
//  CompositionalLayouts
//
//  Created by kou yamamoto on 2021/12/01.
//

import UIKit
import RxSwift
import RxRelay

final class FooterView: UICollectionReusableView {

    let disposeBag = DisposeBag()
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    func bind(observable: Observable<Bool>) {

        // アニメーションしないときは表示しない
        activityIndicator.hidesWhenStopped = true

        // ViewControllerからの入力を受け取り、アニメーションを開始 / 停止する
        observable.withUnretained(self).subscribe(onNext: { owner, isLoading in
            print("didcalled")
            isLoading ? owner.activityIndicator.startAnimating() : owner.activityIndicator.stopAnimating()
        }).disposed(by: disposeBag)
    }
}

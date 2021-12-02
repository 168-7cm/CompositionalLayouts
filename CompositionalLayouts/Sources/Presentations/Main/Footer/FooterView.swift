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
    let isLoadingRelay = BehaviorRelay<Bool>(value: false)
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    func bind() {

        // アニメーションしないときは表示しない
        activityIndicator.hidesWhenStopped = true

        // ViewControllerからの入力を受け取り、アニメーションを開始 / 停止する
        isLoadingRelay.subscribe(onNext: { [weak self] isLoading in
            print(isLoading, "-----isLoading")
            isLoading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
        }).disposed(by: disposeBag)
    }
}

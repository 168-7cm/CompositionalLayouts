//
//  UICollectionView+Utils.swift
//  Bish
//
//  Created by kou yamamoto on 2021/11/23.
//

import UIKit

extension NSObjectProtocol {

    static var className: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView {

    static var identifier: String {
        return className
    }
}

extension UICollectionView {

    func registerCustomCell<T: UICollectionViewCell>(_ cellType: T.Type) {
        register(UINib(nibName: T.identifier, bundle: nil), forCellWithReuseIdentifier: T.identifier)
    }

    func dequeueReusableCustomCell<T: UICollectionViewCell>(with cellType: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }

    func registerCustomHeaderView<T: UICollectionReusableView>(_ cellType: T.Type, kind: String) {
        register(UINib(nibName: T.identifier, bundle: nil), forSupplementaryViewOfKind: kind, withReuseIdentifier: T.identifier)
    }

    func dequeueReusableCustomHeaderView<T: UICollectionReusableView>(with cellType: T.Type, kind: String, indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.identifier, for: indexPath) as! T
    }

    func registerCustomFooterView<T: UICollectionReusableView>(_ cellType: T.Type,  kind: String) {
        register(UINib(nibName: T.identifier, bundle: nil), forSupplementaryViewOfKind: kind, withReuseIdentifier: T.identifier)
    }

    func dequeueReusableCustomFooterView<T: UICollectionReusableView>(with cellType: T.Type, kind: String, indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}

//
//  ViewControllerInstantiable.swift
//  CompositionalLayouts
//
//  Created by kou yamamoto on 2021/05/09.
//

import Foundation

// ViewControllerに依存性を設定するためのプロトコル
protocol ViewControllerInstantiable: AnyObject {
    static func instansiate() -> Self
    associatedtype Dependency
    func inject(with dependency: Dependency)
}

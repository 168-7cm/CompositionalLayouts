//
//  PresenterInstantiable.swift
//  CompositionalLayouts
//
//  Created by kou yamamoto on 2021/05/09.
//

import Foundation

// Presenterに依存性を設定するためのプロトコル
protocol PresenterInstantiable {
    associatedtype Dependency
    func inject(with dependency: Dependency) -> Self
}

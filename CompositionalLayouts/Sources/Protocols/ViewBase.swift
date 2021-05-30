//
//  ViewBase.swift
//  CompositionalLayouts
//
//  Created by kou yamamoto on 2021/05/09.
//

import Foundation

// Viewプロトコルを作成する際に必ず継承する
protocol ViewBase: AnyObject {
    func beginActivityIndicator()
    func endActivityIndicator()
}

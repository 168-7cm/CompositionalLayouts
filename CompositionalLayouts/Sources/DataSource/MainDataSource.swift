//
//  ArticleDataSource.swift
//  Bish
//
//  Created by kou yamamoto on 2021/11/23.
//

import Foundation
import RxDataSources

struct Town: Codable {
    let name: String
    let location: String
    let pupulation: String
}

struct Shop: Codable {
    let name: String
    let location: String
}

enum SectionModel {
    case main(title: String, items: [SectionItem])
    case sub(title: String, items: [SectionItem])
}

enum SectionItem {
    case main(town: Town)
    case sub(shop: Shop)
}

extension SectionModel: SectionModelType {

    typealias Item = SectionItem

    var items: [SectionItem] {
        switch self {
        case .main(title: _, let items):
            return items.map { $0 }
        case .sub(title: _, let items):
            return items.map { $0 }
        }
    }

    init(original: SectionModel, items: [SectionItem]) {
        switch original {
        case let .main(title: title, items: _):
            self = .main(title: title, items: items)
        case let .sub(title: title, items: _):
            self = .sub(title: title, items: items)
        }
    }
}

extension SectionModel {

    var title: String {
        switch self {
        case .main(title: let title, items: _):
            return title
        case .sub(title: let title, items: _):
            return title
        }
    }
}

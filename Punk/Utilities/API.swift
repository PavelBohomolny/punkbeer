//
//  API.swift
//  Punk
//
//  Created by Pavel Bohomolnyi on 27/12/2022.
//

import Foundation

enum API {
    enum Endpoint {
        case beers(page: Page)
        case beerIds(ids: [Int])
        case searchBeers(query: String, page: Page)
    }
}

extension API.Endpoint {
    struct Page {
        var offset: Int
        var limit: Int

        init(offset: Int = 1, limit: Int = 20) {
            self.offset = offset
            self.limit = limit
        }

        var next: Page {
            Page(offset: offset + 1, limit: limit)
        }

        var isFirst: Bool {
            offset == 1
        }
    }
}

//
//  PathGenerator.swift
//  Punk
//
//  Created by Pavel Bohomolnyi on 27/12/2022.
//

import Foundation

protocol PathGeneratorProtocol {
    func url(for endpoint: API.Endpoint) -> URL?
}

struct PathGenerator: PathGeneratorProtocol {
    var host: String

    // MARK: - Lifecycle
    init(host: String) {
        self.host = host
    }

    // MARK: - Endpoints
    func url(for endpoint: API.Endpoint) -> URL? {
        var path = host
        switch endpoint {
        case .beers(let page):
            path += "beers?page=\(page.offset)&per_page=\(page.limit)"
        case .beerIds(let ids):
            let string = ids
                .map { String($0) }
                .joined(separator: "%7C")
            path += "beers?ids=\(string)"
        case let .searchBeers(query, page):
            path += "beers?beer_name=\(query)&page=\(page.offset)&per_page=\(page.limit)"
        }

        return URL(string: path)
    }
}

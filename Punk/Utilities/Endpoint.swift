//
//  Endpoint.swift
//  Punk
//
//  Created by Pavel Bohomolnyi on 27/12/2022.
//

import Foundation

class Endpoint<Response> {
    typealias Parameters = [String: Any]

    enum Method {
        case get, post, put, delete

        var HTTPMethod: String {
            switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
            case .put:
                return "PUT"
            case .delete:
                return "DELETE"
            }
        }
    }

    let method: Method
    let api: API.Endpoint
    let parameters: Parameters?
    let headers: Parameters?

    init(method: Method = .get, api: API.Endpoint, parameters: Parameters? = nil, headers: Parameters? = nil) {
        self.method = method
        self.api = api
        self.parameters = parameters
        self.headers = headers
    }
}

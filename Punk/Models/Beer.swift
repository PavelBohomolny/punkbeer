//
//  Beer.swift
//  Punk
//
//  Created by Pavel Bohomolnyi on 27/12/2022.
//

import Foundation

struct Beer: Identifiable, Codable {
    var id: Int
    var name: String
    var tagline: String?
    var imagePath: String?
    var description: String?
    var foodPairing: [String]?
    var brewersTips: String?
    var contributedBy: String?

    enum CodingKeys: String, CodingKey {
        case id, name, tagline, description
        case imagePath = "image_url"
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
        case contributedBy = "contributed_by"
    }
}

extension Beer: Equatable {
    static func == (lhs: Beer, rhs: Beer) -> Bool {
        lhs.id == rhs.id
    }
}

extension Beer {
    static var mocks: Mocks = Mocks()

    struct Mocks {
        let empty: Beer = Beer(id: -1, name: "")
        let beerPunk: Beer = Beer(
            id: 1,
            name: "Punk IPA",
            tagline: "Cool cold beer",
            imagePath: "https://images.punkapi.com/v2/192.png",
            description: "Some text goes here")

        let beerStout: Beer = Beer(
            id: 2,
            name: "YoHoHo Stout",
            tagline: "Cool hot beer",
            imagePath: "https://images.punkapi.com/v2/191.png",
            description: "Some text goes here")
    }
}


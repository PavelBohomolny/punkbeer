//
//  BeerDisplayingProtocol.swift
//  Punk
//
//  Created by Pavel Bohomolnyi on 27/12/2022.
//

import Foundation

protocol BeerDisplayingProtocol {
    var appState: AppState { get }
}

extension BeerDisplayingProtocol {
    func model(for beer: Beer) -> BeerViewModel {
        appState.model(for: beer)
    }
}

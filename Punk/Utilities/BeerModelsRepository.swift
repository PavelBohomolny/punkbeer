//
//  BeerModelsRepository.swift
//  Punk
//
//  Created by Pavel Bohomolnyi on 27/12/2022.
//

import Foundation

class BeerModelsRepository {
    private var appState: AppState
    private var cachedBeerModels: [BeerViewModel] = []

    // MARK: - Lifecycle
    init(appState: AppState) {
        self.appState = appState
    }

    func model(for beer: Beer) -> BeerViewModel {
        guard let model = cachedBeerModels.first(where: { $0.beer == beer }) else {
            let model = BeerViewModel(beer: beer, appState: appState)
            cachedBeerModels.append(model)
            return model
        }
        return model
    }
}

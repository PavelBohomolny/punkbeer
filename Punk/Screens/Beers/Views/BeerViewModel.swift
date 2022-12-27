//
//  BeerViewModel.swift
//  Punk
//
//  Created by Pavel Bohomolnyi on 27/12/2022.
//

import Combine
import Foundation

class BeerViewModel: ObservableObject {
    @Published var isFavorited: Bool

    private(set) var beer: Beer

    private var appState: AppState

    // MARK: - Lifecycle
    init(beer: Beer, appState: AppState) {
        self.beer = beer
        self.appState = appState
        self.isFavorited = appState.isBeerFavorited(beer)
    }
}

// MARK: - Properties
extension BeerViewModel {
    
    var title: String {
        beer.name
    }

    var subtitle: String {
        beer.tagline ?? ""
    }

    var description: String {
        beer.description ?? ""
    }

    var foodPairing: [String] {
        beer.foodPairing ?? []
    }

    var brewerTips: String {
        beer.brewersTips ?? ""
    }

    var contributedBy: String {
        beer.contributedBy ?? ""
    }

    var imageURL: URL? {
        guard let path = beer.imagePath else { return nil }
        return URL(string: path)
    }

    var favoriteImageName: String {
        isFavorited ? "heart.fill" : "heart"
    }
}

// MARK: - Actions
extension BeerViewModel {
    func pressedFavorite() {
        appState.toggleFavorite(for: beer)
    }
}

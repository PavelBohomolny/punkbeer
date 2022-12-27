//
//  PunkAppTabViewModel.swift
//  Punk
//
//  Created by Pavel Bohomolnyi on 27/12/2022.
//

import Combine

class PunkAppTabViewModel: ObservableObject {
    @Published var tabIndex: Int = 0
    
    private(set) var beersViewModel: BeersViewModel
    private(set) var favoritesViewModel: FavoritesViewModel
    
    private var appState: AppState
    private var cancellables: [AnyCancellable] = []
    
    // MARK: - Lifecycle
    init(appState: AppState) {
        self.appState = appState
        self.beersViewModel = BeersViewModel(appState: appState)
        self.favoritesViewModel = FavoritesViewModel(appState: appState)
        
        setupObservables()
    }
    
    private func setupObservables() {
        $tabIndex
            .dropFirst()
            .sink { index in
                print("New tab index: \(index)")
            }
            .store(in: &cancellables)
    }
}

// MARK: - Properties
extension PunkAppTabViewModel {
    var beersImageName: String {
        tabIndex == 0 ? "mug.fill" : "mug"
    }
    
    var favoritesImageName: String {
        tabIndex == 1 ? "suit.heart.fill" : "suit.heart"
    }
}

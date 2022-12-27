//
//  BeersViewModel.swift
//  Punk
//
//  Created by Pavel Bohomolnyi on 27/12/2022.
//

import Combine
import Foundation

class BeersViewModel: ObservableObject, FiniteStateViewModel, BeerDisplayingProtocol {
    @Published var state: ViewModelState = .none
    @Published var beers: [Beer] = []
    @Published var query: String = ""

    private(set) var canLoadMore: Bool = true

    internal var appState: AppState

    private var cancellables: [AnyCancellable] = []
    private var page: API.Endpoint.Page = .init()

    // MARK: - Lifecycle
    init(appState: AppState) {
        self.appState = appState

        setupObservables()
        load()
    }

    private func setupObservables() {
        $query
            .dropFirst()
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] value in
                guard let self = self else { return }
                self.page = API.Endpoint.Page()
                self.fetch(query: value)
            }
            .store(in: &cancellables)
    }
}

// MARK: - API
extension BeersViewModel {
    func loadMore() {
        guard state != .loading else { return }
        guard canLoadMore else { return }
        page = page.next
        state = .loading
        fetch()
    }

    private func load() {
        guard state == .none else { return }
        state = .loading
        fetch()
    }

    private func fetch(query: String = "") {
        let endpointPath: API.Endpoint = query.isEmpty
            ? .beers(page: page)
            : .searchBeers(query: query, page: page)

        let endpoint = Endpoint<[Beer]>(
            method: .get,
            api: endpointPath)

        appState.client.performRequest(endpoint: endpoint) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .failure(let error):
                self.state = .error(error)
            case .success(let content):
                if self.page.isFirst {
                    self.beers = content
                } else {
                    self.beers.append(contentsOf: content)
                }

                self.canLoadMore = content.count == self.page.limit
                self.state = .success
            }
        }
    }
}

extension BeersViewModel {
    func prepareForPreview() {
        beers = [Beer.mocks.beerPunk, Beer.mocks.beerStout]
        state = .success
    }
}

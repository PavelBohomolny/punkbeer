//
//  BeersView.swift
//  Punk
//
//  Created by Pavel Bohomolnyi on 27/12/2022.
//

import SwiftUI

struct BeersView: View {
    @ObservedObject var model: BeersViewModel

    var body: some View {
        let content = VStack {
            SearchBar(text: $model.query)
                .padding(.horizontal, 10)

            List {
                switch model.state {
                case .error(let error):
                    ErrorView(failureReason: error)

                case .success, .none, .loading:
                    if !model.beers.isEmpty {
                        Section {
                            ForEach(model.beers) { beer in
                                let detailsModel = model.model(for: beer)
                                NavigationLink(destination: BeerDetailsView(model: detailsModel)) {
                                    BeerCellView(model: detailsModel)
                                }
                            }
                        }
                    } else if !model.canLoadMore {
                        Text("No results")
                    }

                    if model.canLoadMore {
                        Section {
                            LoadingCellView()
                                .onAppear { model.loadMore() }
                        }
                    }
                }
            }
        }
        
        content
            .navigationTitle("Punk Beers")
            .listStyle(PlainListStyle())
            .navigationBarTitleDisplayMode(.inline) // If you want to follow Apple's guideline, comment this line. But I like more minimal design, up to you!
    }
}

struct BeersView_Previews: PreviewProvider {
    static var previews: some View {
        let model = BeersViewModel(appState: AppState.mock)
        model.prepareForPreview()

        let view = NavigationView {
            BeersView(model: model)
        }

        return Group {
            view.colorScheme(.dark)
        }
    }
}

//
//  PunkAppTabView.swift
//  Punk
//
//  Created by Pavel Bohomolnyi on 27/12/2022.
//

import SwiftUI

struct PunkAppTabView: View {
    typealias TabData = (name: String, icon: String, view: AnyView)
    
    @ObservedObject var model: PunkAppTabViewModel
    
    var body: some View {
        
        let views: [TabData] = [
                    ("Beers", model.beersImageName, BeersView(model: model.beersViewModel).toAnyView),
                    ("Favorites", model.favoritesImageName, FavoritesView(model: model.favoritesViewModel).toAnyView)
                ]

        TabView(selection: $model.tabIndex) {
            let data = Array(zip(views.indices, views))
            ForEach(data, id: \.0) { index, view in
                NavigationView {
                    view.view
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .tabItem { Label(view.name, systemImage: view.icon) }
                .tag(index)
            }
        }
    }
}

struct PunkAppTabView_Previews: PreviewProvider {
    static var previews: some View {
        PunkAppTabView(model: PunkAppTabViewModel(appState: AppState()))
    }
}

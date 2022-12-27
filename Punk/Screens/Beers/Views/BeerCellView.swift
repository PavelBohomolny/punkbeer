//
//  BeerCellView.swift
//  Punk
//
//  Created by Pavel Bohomolnyi on 27/12/2022.
//

import SwiftUI

struct BeerCellView: View {
    
    @ObservedObject var model: BeerViewModel
    
    var body: some View {
        
        HStack(alignment: .top) {
            
            BeerImageView(url: model.imageURL, width: 60)
            
            VStack(alignment: .leading) {
                Text(model.title)
                    .font(.headline)
                
                if !model.subtitle.isEmpty {
                    Text(model.subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.top, 5)
                }
            }
            
            if model.isFavorited {
                Spacer()
                VStack {
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    Spacer()
                }
            }
        }
        .contextMenu {
            Button(
                action: { model.pressedFavorite() },
                label: {
                    Image(systemName: model.favoriteImageName)
                })
        }
        .padding(.vertical, 10)
    }
}

struct BeerCellView_Previews: PreviewProvider {
    static var previews: some View {
        let model = BeerViewModel(beer: Beer.mocks.beerPunk, appState: AppState.mock)
        let view = List {
            BeerCellView(model: model)
        }
        
        return Group {
            view.colorScheme(.dark)
        }
        .previewLayout(.fixed(width: 375, height: 400))
    }
}

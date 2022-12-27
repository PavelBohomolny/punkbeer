//
//  LoadingCellView.swift
//  Punk
//
//  Created by Pavel Bohomolnyi on 27/12/2022.
//

import SwiftUI

struct LoadingCellView: View {
    var body: some View {
        Section(header: HStack {
            Spacer()
            ProgressView()
                .padding(.vertical, 16)
            Spacer()
        }) {}
    }
}

struct LoadingCellView_Previews: PreviewProvider {
    static var previews: some View {
        let view = List {
            LoadingCellView()
        }

        return Group {
            view.colorScheme(.dark)
        }
        .previewLayout(.fixed(width: 375, height: 400))
    }
}

//
//  ErrorView.swift
//  Punk
//
//  Created by Pavel Bohomolnyi on 27/12/2022.
//

import SwiftUI

struct ErrorView: View {
    var failureReason: FailureReason

    var body: some View {
        VStack {
            Image(systemName: "xmark.octagon")
                .resizable()
                .foregroundColor(.secondary)
                .frame(width: 100, height: 100)

            Text(failureReason.message)
        }
        .multilineTextAlignment(.center)
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        let view = NavigationView {
            ErrorView(failureReason: FailureReason.message("Something goes wrong"))
        }

        return Group {
            view.colorScheme(.dark)
        }
        .previewLayout(.fixed(width: 375, height: 400))
    }
}

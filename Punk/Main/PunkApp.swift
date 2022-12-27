//
//  PunkApp.swift
//  Punk
//
//  Created by Pavel Bohomolnyi on 27/12/2022.
//

import SwiftUI

@main
struct PunkApp: App {
    var body: some Scene {
        let appState = AppState()
        let model = PunkAppTabViewModel(appState: appState)

        return WindowGroup {
            PunkAppTabView(model: model)
        }
    }
}

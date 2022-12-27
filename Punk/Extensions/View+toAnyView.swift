//
//  View+toAnyView.swift
//  Punk
//
//  Created by Pavel Bohomolnyi on 27/12/2022.
//

import SwiftUI

extension View {
    var toAnyView: AnyView {
        AnyView(self)
    }
}

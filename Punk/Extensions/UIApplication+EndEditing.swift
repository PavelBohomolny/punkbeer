//
//  UIApplication+EndEditing.swift
//  Punk
//
//  Created by Pavel Bohomolnyi on 27/12/2022.
//

import UIKit

// Extension for keyboard to dismiss
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

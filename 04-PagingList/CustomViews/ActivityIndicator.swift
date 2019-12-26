//
//  ActivityIndicator.swift
//  WhiteTerminal
//
//  Created by Oleg Shipulin on 06.12.2019.
//  Copyright © 2019 Oleg Shipulin. All rights reserved.
//

import SwiftUI
import UIKit

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isLoading: Bool

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        if isLoading {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}

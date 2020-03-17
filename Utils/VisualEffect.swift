//
//  VisualEffect.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2020/03/14.
//  Copyright © 2020 g4zeru. All rights reserved.
//

import SwiftUI

struct VisualEffect {
    private var _effect: UIVisualEffect?
    private init(effect: UIVisualEffect) {
        _effect = effect
    }
}

extension VisualEffect {
    static func blurEffect(style: UIBlurEffect.Style) -> Self {
        VisualEffect(effect: UIBlurEffect(style: style))
    }
}

extension VisualEffect: UIViewRepresentable {
    func makeUIView(context _: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: _effect)
    }

    func updateUIView(_ uiView: UIVisualEffectView, context _: Context) {
        uiView.effect = _effect
    }
}

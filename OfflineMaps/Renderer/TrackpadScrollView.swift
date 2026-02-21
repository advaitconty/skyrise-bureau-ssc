//
//  TrackpadScrollView.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 21/2/26.
//

import SwiftUI
import UIKit

/// A transparent overlay that captures two-finger trackpad scroll gestures
/// (which `DragGesture` does not handle) and forwards deltas to callbacks.
struct TrackpadScrollView: UIViewRepresentable {
    var onScroll: (CGSize) -> Void
    var onEnd: () -> Void

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear

        let pan = UIPanGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePan(_:)))
        pan.allowedScrollTypesMask = .all
        pan.minimumNumberOfTouches = 0
        pan.maximumNumberOfTouches = 0 
        view.addGestureRecognizer(pan)

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        context.coordinator.onScroll = onScroll
        context.coordinator.onEnd = onEnd
    }

    func makeCoordinator() -> Coordinator { Coordinator(onScroll: onScroll, onEnd: onEnd) }

    final class Coordinator: NSObject {
        var onScroll: (CGSize) -> Void
        var onEnd: () -> Void
        private var lastTranslation: CGPoint = .zero

        init(onScroll: @escaping (CGSize) -> Void, onEnd: @escaping () -> Void) {
            self.onScroll = onScroll
            self.onEnd = onEnd
        }

        @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
            let translation = gesture.translation(in: gesture.view)
            switch gesture.state {
            case .began:
                lastTranslation = .zero
            case .changed:
                let delta = CGSize(
                    width:  translation.x - lastTranslation.x,
                    height: translation.y - lastTranslation.y
                )
                lastTranslation = CGPoint(x: translation.x, y: translation.y)
                onScroll(delta)
            case .ended, .cancelled:
                onEnd()
                lastTranslation = .zero
            default:
                break
            }
        }
    }
}

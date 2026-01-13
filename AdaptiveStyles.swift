//
//  AdaptiveButtonStyles.swift
//  Skyrise Bureau Swift Playgrounds
//
//  Created by Advait Contractor on 13/1/26.
//

import SwiftUI
import Foundation

extension View {
    @ViewBuilder
    func adaptiveProminentButtonStyle() -> some View {
        if #available(iOS 26.0, macOS 26.0, *) {
            self.buttonStyle(.glassProminent)
        } else {
            self.buttonStyle(.borderedProminent)
        }
    }
}

extension View {
    @ViewBuilder
    func adaptiveButtonStyle() -> some View {
        if #available(iOS 26.0, macOS 26.0, *) {
            self.buttonStyle(.glass)
        } else {
            self.buttonStyle(.bordered)
        }
    }
}

func GlassTextField(_ placeholder: String, _ editedText: Binding<String>, _ textBeforeTextField: String, monospaced: Bool = false) -> some View {
    VStack {
        if #available(iOS 26.0, macOS 26.0, *) {
            HStack {
                Text(placeholder)
                    .fontWidth(.expanded)
                TextField(textBeforeTextField, text: editedText)
                    .fontWidth(.condensed)
                    .monospaced(monospaced)
            }
            .padding()
            .glassEffect()
        } else {
            HStack {
                Text(placeholder)
                    .fontWidth(.expanded)
                TextField(textBeforeTextField, text: editedText)
                    .fontWidth(.condensed)
                    .monospaced(monospaced)
                    .textFieldStyle(.roundedBorder)
            }
        }
    }
}

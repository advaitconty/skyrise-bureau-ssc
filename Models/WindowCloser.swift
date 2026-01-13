//
//  WindowCloser.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 13/11/25.
//


import SwiftUI

struct WindowCloser: View {
    @Environment(\.dismissWindow) var dissmissWindow
    var body: some View {
        ProgressView()
            .onAppear {
                dissmissWindow()
            }
    }
}

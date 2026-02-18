//
//  AdaptiveAircraftLayout.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 17/2/26.
//

import SwiftUI

struct AdaptiveAircraftLayout<Image: View, Info: View>: View {
    let image: Image
    let info: Info

    @State private var imageHeight: CGFloat = 0
    @State private var infoPanelHeight: CGFloat = 0

    var shouldStack: Bool {
        infoPanelHeight > imageHeight && imageHeight > 0
    }

    var body: some View {
        Group {
            if shouldStack {
                VStack(alignment: .leading) {
                    image
                    info
                }
            } else {
                HStack(alignment: .top) {
                    image
                    info
                }
            }
        }
        .background(
            // Invisible overlay that measures both children after layout
            GeometryReader { _ in
                HStack(alignment: .top) {
                    Color.clear
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            GeometryReader { geo in
                                Color.clear.preference(key: HeightPreferenceKey.self, value: geo.size.height)
                            }
                        )
                        .onPreferenceChange(HeightPreferenceKey.self) { h in
                            DispatchQueue.main.async { imageHeight = h }
                        }

                    Color.clear
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            GeometryReader { geo in
                                Color.clear.preference(key: HeightPreferenceKey.self, value: geo.size.height)
                            }
                        )
                        .onPreferenceChange(HeightPreferenceKey.self) { h in
                            DispatchQueue.main.async { infoPanelHeight = h }
                        }
                }
            }
        )
    }
}

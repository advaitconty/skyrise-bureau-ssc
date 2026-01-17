//
//  TestMapView.swift
//  Skyrise Bureau
//
//  Created by Advait Contractor on 16/1/26.
//

import SwiftUI

struct TestMapRenderView: View {
    @State var zoomFactor: Double = 1
    @State var panFactor: Double = 1
    @State private var offset = CGSize.zero
    @State private var lastOffset = CGSize.zero
    @State private var lastZoomFactor: Double = 1
    var body: some View {
        Image("World")
            .resizable()
            .scaledToFit()
            .scaleEffect(zoomFactor)
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        offset = CGSize(width: lastOffset.width + value.translation.width, height: lastOffset.height + value.translation.height)
                    }
                    .onEnded { _ in
                        lastOffset = offset
                    }
                    .simultaneously(with:
                        MagnificationGesture()
                            .onChanged { value in
                                zoomFactor = lastZoomFactor * value
                            }
                            .onEnded { _ in
                                lastZoomFactor = zoomFactor
                            }
                    )
            )
    }
}

#Preview {
    TestMapRenderView()
}

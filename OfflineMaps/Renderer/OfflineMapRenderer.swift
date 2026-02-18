//
//  OfflineMapRenderer.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 18/2/26.
//

import CoreLocation
import Foundation
import SwiftUI

struct _OfflineMapRenderer: View {
    @Binding var position: OfflineMapPosition
    let annotations:   [OfflineAnnotation]
    let routes:        [OfflineRoute]
    let oceanColor, landColor, gridColor: Color
    let routeActive, routeInactive: Color
    let hubColor, airportColor, aircraftColor: Color
    
    @State var proj = Projection(centerLat: 25, centerLon: 15, zoom: 2.2, size: .zero)
    @State var selectedAnnotation: OfflineAnnotation? = nil
    @GestureState var liveDrag: CGSize = .zero
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                oceanColor.ignoresSafeArea()
                
                Canvas { ctx, size in
                    var p = proj
                    p.size = size
                    if liveDrag != .zero {
                        p.pan(by: CGSize(width: -liveDrag.width, height: -liveDrag.height))
                    }
                    drawGrid(ctx: ctx, p: p)
                    drawLand(ctx: ctx, p: p)
                    drawRoutes(ctx: ctx, p: p)
                    drawAnnotations(ctx: ctx, p: p)
                }
                .gesture(
                    DragGesture(minimumDistance: 2)
                        .updating($liveDrag) { v, s, _ in s = v.translation }
                        .onEnded { v in
                            proj.size = geo.size
                            proj.pan(by: CGSize(width: -v.translation.width,
                                                height: -v.translation.height))
                            syncPosition()
                        }
                )
                .gesture(
                    MagnificationGesture()
                        .onChanged { v in
                            proj.zoom = max(1.5, min(7, proj.zoom + Double(log2(Float(v))) * 0.5))
                            syncPosition()
                        }
                )
                .onTapGesture { loc in
                    proj.size = geo.size
                    handleTap(at: loc)
                }
                .onAppear {
                    proj.size      = geo.size
                    proj.centerLat = position.latitude
                    proj.centerLon = position.longitude
                    proj.zoom      = position.zoom
                }
                .onChange(of: geo.size) { proj.size = $0 }
                .onChange(of: position) {
                    withAnimation(.spring(duration: 0.4)) {
                        proj.centerLat = position.latitude
                        proj.centerLon = position.longitude
                        proj.zoom      = position.zoom
                    }
                }
                
                // Callout
                if let ann = selectedAnnotation {
                    let pt = proj.point(for: ann.coordinate)
                    calloutView(for: ann)
                        .position(
                            x: min(max(pt.x, 130), geo.size.width - 130),
                            y: max(pt.y - 65, 70)
                        )
                        .transition(.scale(scale: 0.85).combined(with: .opacity))
                        .animation(.spring(duration: 0.22), value: selectedAnnotation?.id)
                }
                
                // Controls
                VStack {
                    HStack { Spacer(); controls }
                    Spacer()
                }
                .padding(16)
            }
        }
        .background(oceanColor)
    }
}

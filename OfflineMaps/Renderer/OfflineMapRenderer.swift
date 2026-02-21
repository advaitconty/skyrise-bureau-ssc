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
    @State var trackpadScroll: CGSize = .zero
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                oceanColor.ignoresSafeArea()
                
                Canvas { ctx, size in
                    var p = proj
                    p.size = size
                    let totalDrag = CGSize(
                        width:  liveDrag.width  + trackpadScroll.width,
                        height: liveDrag.height + trackpadScroll.height
                    )
                    if totalDrag != .zero {
                        p.pan(by: totalDrag)
                    }
                    drawGrid(ctx: ctx, p: p)
                    drawLand(ctx: ctx, p: p)
                    drawRoutes(ctx: ctx, p: p)
                    drawAnnotations(ctx: ctx, p: p)
                }
                .overlay {
                    TrackpadScrollView { delta in
                        trackpadScroll.width  += delta.width
                        trackpadScroll.height += delta.height
                    } onEnd: {
                        proj.size = geo.size
                        proj.pan(by: trackpadScroll)
                        trackpadScroll = .zero
                        syncPosition()
                    }
                }
                .gesture(
                    DragGesture(minimumDistance: 2)
                        .updating($liveDrag) { v, s, _ in s = v.translation }
                        .onEnded { v in
                            proj.size = geo.size
                            proj.pan(by: CGSize(width: v.translation.width,
                                                height: v.translation.height))
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
                .onChange(of: geo.size) { oldSize, newSize in
                    if proj.size != newSize {
                        proj.size = newSize
                    }
                }
//                .onChange(of: position) { oldPos, newPos in
//                    if abs(proj.centerLat - newPos.latitude) > 0.0001
//                        || abs(proj.centerLon - newPos.longitude) > 0.0001
//                        || abs(proj.zoom - newPos.zoom) > 0.0001 {
//                        withAnimation(.spring(duration: 0.4)) {
//                            proj.centerLat = newPos.latitude
//                            proj.centerLon = newPos.longitude
//                            proj.zoom      = newPos.zoom
//                        }
//                    }
//                }
                
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
                    Spacer()
                    HStack {
                        Spacer()
                        controls
                    }
                }
                .padding(16)
            }
        }
        .background(oceanColor)
    }
}

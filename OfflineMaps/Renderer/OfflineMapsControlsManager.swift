//
//  OfflineMapsControlsManager.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 18/2/26.
//

import Foundation
import CoreLocation
import SwiftUI

extension _OfflineMapRenderer {
    var controls: some View {
        VStack(spacing: 8) {
            Text("N")
                .fontWidth(.condensed)
                .frame(width: 15, height: 15)
                .padding()
                .glassEffect()
            
            controlButton("plus")    { proj.zoom = min(7,   proj.zoom + 0.5); proj.clamp(); syncPosition() }
            controlButton("minus")   { proj.zoom = max(1.5, proj.zoom - 0.5); proj.clamp(); syncPosition() }
            controlButton("arrow.counterclockwise") {
                withAnimation(.spring(duration: 0.4)) {
                    proj.centerLat = position.latitude
                    proj.centerLon = position.longitude
                    proj.zoom      = position.zoom
                    proj.clamp()
                    selectedAnnotation = nil
                }
            }
        }
    }
    
    func controlButton(_ icon: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            ZStack {
                Image(systemName: icon).font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white.opacity(0.8))
            }
            .frame(width: 15, height: 15)
        }
        .adaptiveButtonStyle()
    }
}

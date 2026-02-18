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
            ZStack {
                Circle().fill(.ultraThinMaterial).frame(width: 36, height: 36)
                Text("N").font(.system(size: 11, weight: .heavy, design: .monospaced))
                    .foregroundColor(.white.opacity(0.9))
            }
            .overlay(Circle().stroke(Color.white.opacity(0.1), lineWidth: 1))
            controlButton("plus")    { proj.zoom = min(7,   proj.zoom + 0.5); syncPosition() }
            controlButton("minus")   { proj.zoom = max(1.5, proj.zoom - 0.5); syncPosition() }
            controlButton("arrow.counterclockwise") {
                withAnimation(.spring(duration: 0.4)) {
                    proj.centerLat = position.latitude
                    proj.centerLon = position.longitude
                    proj.zoom      = position.zoom
                    selectedAnnotation = nil
                }
            }
        }
    }
    
    func controlButton(_ icon: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 8).fill(.ultraThinMaterial).frame(width: 36, height: 36)
                Image(systemName: icon).font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white.opacity(0.8))
            }
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.white.opacity(0.1), lineWidth: 1))
        }
        .buttonStyle(.plain)
    }
}

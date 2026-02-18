//
//  OfflineMapsPositionManager.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 18/2/26.
//

import Foundation
import CoreLocation
import SwiftUI

extension _OfflineMapRenderer {
    func handleTap(at loc: CGPoint) {
        let nearest = annotations.min(by: {
            let a = proj.point(for: $0.coordinate), b = proj.point(for: $1.coordinate)
            return hypot(a.x - loc.x, a.y - loc.y) < hypot(b.x - loc.x, b.y - loc.y)
        })
        guard let n = nearest else { return }
        let pt = proj.point(for: n.coordinate)
        withAnimation(.spring(duration: 0.22)) {
            selectedAnnotation = hypot(pt.x - loc.x, pt.y - loc.y) < 30 ? (selectedAnnotation?.id == n.id ? nil : n) : nil
        }
    }
    
    func syncPosition() {
        position = OfflineMapPosition(latitude: proj.centerLat,
                                      longitude: proj.centerLon,
                                      zoom: proj.zoom)
    }
}

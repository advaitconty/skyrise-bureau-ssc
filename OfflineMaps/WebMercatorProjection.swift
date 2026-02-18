//
//  WebMercatorProjection.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 18/2/26.
//

import Foundation
import CoreLocation

struct Projection {
    var centerLat: Double
    var centerLon: Double
    var zoom:      Double
    var size:      CGSize

    private var scale: Double { pow(2.0, zoom) * 256.0 }

    private func mx(_ lon: Double) -> Double { (lon + 180) / 360 }
    private func my(_ lat: Double) -> Double {
        let s = sin(lat * .pi / 180)
        return 0.5 - log((1 + s) / (1 - s)) / (4 * .pi)
    }

    func point(for c: CLLocationCoordinate2D) -> CGPoint {
        CGPoint(
            x: (mx(c.longitude) - mx(centerLon)) * scale + size.width  / 2,
            y: (my(c.latitude)  - my(centerLat)) * scale + size.height / 2
        )
    }

    func coordinate(for p: CGPoint) -> CLLocationCoordinate2D {
        let px = (p.x - size.width  / 2) / scale + mx(centerLon)
        let py = (p.y - size.height / 2) / scale + my(centerLat)
        return CLLocationCoordinate2D(
            latitude:  atan(sinh(.pi * (1 - 2 * py))) * 180 / .pi,
            longitude: px * 360 - 180
        )
    }

    mutating func pan(by offset: CGSize) {
        let c = coordinate(for: CGPoint(
            x: size.width  / 2 - offset.width,
            y: size.height / 2 - offset.height
        ))
        centerLat = max(-80, min(80, c.latitude))
        centerLon = c.longitude
    }
}

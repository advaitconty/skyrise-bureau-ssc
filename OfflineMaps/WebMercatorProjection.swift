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
        centerLat = c.latitude
        centerLon = c.longitude
        clamp()
    }

    mutating func clamp() {
        guard size.width > 0, size.height > 0 else {
            centerLat = max(-80, min(80, centerLat))
            centerLon = max(-180, min(180, centerLon))
            return
        }

        let buffer: Double = 750

        let halfW = max(0, (size.width  / 2) - buffer) / scale
        let halfH = max(0, (size.height / 2) - buffer) / scale

        let mxMin = mx(-180)
        let mxMax = mx( 180)
        let lonRange = mxMax - mxMin

        if halfW * 2 >= lonRange {
            centerLon = 0
        } else {
            let cxMin = mxMin + halfW
            let cxMax = mxMax - halfW
            let cx = max(cxMin, min(cxMax, mx(centerLon)))
            centerLon = cx * 360 - 180
        }

        let myTop    = my( 80)
        let myBottom = my(-80)

        if halfH * 2 >= (myBottom - myTop) {
            centerLat = 0
        } else {
            let cyMin = myTop    + halfH
            let cyMax = myBottom - halfH
            let cy = max(cyMin, min(cyMax, my(centerLat)))
            centerLat = atan(sinh(.pi * (1 - 2 * cy))) * 180 / .pi
        }
    }
}

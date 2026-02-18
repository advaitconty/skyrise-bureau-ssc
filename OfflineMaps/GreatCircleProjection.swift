//
//  GreatCircleProjection.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 18/2/26.
//

import Foundation
import CoreLocation

func greatCircle(from a: CLLocationCoordinate2D,
                         to b: CLLocationCoordinate2D,
                         steps: Int = 60) -> [CLLocationCoordinate2D] {
    let lat1 = a.latitude  * .pi / 180, lon1 = a.longitude * .pi / 180
    let lat2 = b.latitude  * .pi / 180, lon2 = b.longitude * .pi / 180
    let d = 2 * asin(sqrt(pow(sin((lat2-lat1)/2), 2) + cos(lat1)*cos(lat2)*pow(sin((lon2-lon1)/2), 2)))
    guard d > 0 else { return [a, b] }
    return (0...steps).map { i in
        let t = Double(i) / Double(steps)
        let A = sin((1-t)*d)/sin(d), B = sin(t*d)/sin(d)
        let x = A*cos(lat1)*cos(lon1) + B*cos(lat2)*cos(lon2)
        let y = A*cos(lat1)*sin(lon1) + B*cos(lat2)*sin(lon2)
        let z = A*sin(lat1)           + B*sin(lat2)
        return CLLocationCoordinate2D(
            latitude:  atan2(z, sqrt(x*x+y*y)) * 180 / .pi,
            longitude: atan2(y, x) * 180 / .pi
        )
    }
}


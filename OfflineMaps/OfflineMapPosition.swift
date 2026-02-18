//
//  OfflineMapPosition.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 18/2/26.
//

import CoreLocation

struct OfflineMapPosition: Equatable {
    var latitude: Double
    var longitude: Double
    var zoom: Double

    static func region(center: CLLocationCoordinate2D, zoom: Double = 2.5) -> Self {
        OfflineMapPosition(latitude: center.latitude, longitude: center.longitude, zoom: zoom)
    }

    static var world: Self {
        OfflineMapPosition(latitude: 25, longitude: 15, zoom: 2.2)
    }
}

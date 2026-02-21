//
//  MapAnnotations.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 18/2/26.
//

import Foundation
import CoreLocation
import SwiftUI

extension Airport {
    func asOfflineAnnotation(hubIATAs: [String] = []) -> OfflineAnnotation {
        OfflineAnnotation(
            id: iata,
            coordinate: clLocationCoordinateItemForLocation,
            kind: .airport(
                iata: iata,
                icao: icao,
                name: name,
                city: city,
                country: country,
                isHub: hubIATAs.contains(iata)
            )
        )
    }
}

extension FleetItem {
    private var headingToDestination: Double? {
        guard isAirborne, let route = assignedRoute else { return nil }
        let from = planeLocationInFlight
        let to   = route.arrivalAirport.clLocationCoordinateItemForLocation

        let lat1 = from.latitude  * .pi / 180
        let lat2 = to.latitude    * .pi / 180
        let dLon = (to.longitude - from.longitude) * .pi / 180

        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        let rad = atan2(y, x)
        return rad * 180 / .pi    
    }

    func asOfflineAnnotation() -> OfflineAnnotation {
        OfflineAnnotation(
            id: id.uuidString,
            coordinate: planeLocationInFlight,
            kind: .aircraft(registration: registration, isAirborne: isAirborne, heading: headingToDestination)
        )
    }
}

extension Route {
    func asOfflineRoute(isActive: Bool = false) -> OfflineRoute {
        OfflineRoute(
            origin: CLLocationCoordinate2D(latitude: originAirport.latitude, longitude: originAirport.longitude),
            destination: CLLocationCoordinate2D(latitude: arrivalAirport.latitude, longitude: arrivalAirport.longitude),
            isActive: isActive
        )
    }
}

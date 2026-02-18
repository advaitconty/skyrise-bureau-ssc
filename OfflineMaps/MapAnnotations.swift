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
            kind: .airport(iata: iata, name: name, isHub: hubIATAs.contains(iata))
        )
    }
}

extension FleetItem {
    func asOfflineAnnotation() -> OfflineAnnotation {
        OfflineAnnotation(
            id: id.uuidString,
            coordinate: planeLocationInFlight,
            kind: .aircraft(registration: registration, isAirborne: isAirborne)
        )
    }
}

extension Route {
    func asOfflineRoute(isActive: Bool = false) -> OfflineRoute {
        OfflineRoute(
            origin: CLLocationCoordinate2D(latitude: originAirport.latitude,  longitude: originAirport.longitude),
            destination: CLLocationCoordinate2D(latitude: arrivalAirport.latitude, longitude: arrivalAirport.longitude),
            isActive: isActive
        )
    }
}

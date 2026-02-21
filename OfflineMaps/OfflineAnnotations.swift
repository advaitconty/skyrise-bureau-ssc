//
//  OfflineAnnotations.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 18/2/26.
//

import CoreLocation

enum OfflineAnnotationKind {
    case airport(iata: String, icao: String, name: String, city: String, country: String, isHub: Bool)
    case aircraft(registration: String, isAirborne: Bool, heading: Double?)
}

struct OfflineAnnotation: Identifiable {
    let id: String
    let coordinate: CLLocationCoordinate2D
    let kind: OfflineAnnotationKind
}

struct OfflineRoute: Identifiable {
    let id: UUID = UUID()
    let origin: CLLocationCoordinate2D
    let destination: CLLocationCoordinate2D
    let isActive: Bool
}

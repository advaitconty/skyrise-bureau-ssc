//
//  MapItem.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 8/12/25.
//

import SwiftUI
import MapKit

extension AirportPickerView {
    func mapItem() -> some View {
        OfflineMap(position: $mapCameraPosition) {
            OfflineMapContentGroup(
                annotations: filteredAirports.map { airport in
                    OfflineAnnotation(
                        id: airport.iata,
                        coordinate: airport.clLocationCoordinateItemForLocation,
                        kind: .airport(
                            iata: airport.reportCorrectCodeForUserData(userData),
                            name: airport.name,
                            isHub: airportSelected == airport
                        )
                    )
                },
                routes: []
            )
        }
    }
}

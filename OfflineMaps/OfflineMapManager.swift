//
//  OfflineMapManager.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 18/2/26.
//

import SwiftUI
import Foundation
import CoreLocation

struct OfflineMap: View {
    @Binding var position: OfflineMapPosition
    var content: OfflineMapContentGroup

    init(position: Binding<OfflineMapPosition>,
         @OfflineMapBuilder content: () -> OfflineMapContentGroup) {
        self._position = position
        self.content = content()
    }
}

extension OfflineMap {
    private var oceanColor:    Color { Color(red: 0.07, green: 0.09, blue: 0.12) }
    private var landColor:     Color { Color(red: 0.17, green: 0.22, blue: 0.20) }
    private var gridColor:     Color { Color.white.opacity(0.04) }
    private var routeActive:   Color { Color(red: 0.25, green: 0.85, blue: 0.55) }
    private var routeInactive: Color { Color.white.opacity(0.2) }
    private var hubColor:      Color { Color(red: 0.25, green: 0.85, blue: 0.55) }
    private var airportColor:  Color { Color(red: 0.9,  green: 0.75, blue: 0.3) }
    private var aircraftColor: Color { Color(red: 0.4,  green: 0.7,  blue: 1.0) }

    var body: some View {
        _OfflineMapRenderer(
            position:      $position,
            annotations:   content.annotations,
            routes:        content.routes,
            oceanColor:    oceanColor,
            landColor:     landColor,
            gridColor:     gridColor,
            routeActive:   routeActive,
            routeInactive: routeInactive,
            hubColor:      hubColor,
            airportColor:  airportColor,
            aircraftColor: aircraftColor
        )
    }
}

@resultBuilder
struct OfflineMapBuilder {
    static func buildBlock(_ components: OfflineMapContentGroup...) -> OfflineMapContentGroup {
        OfflineMapContentGroup(
            annotations: components.flatMap(\.annotations),
            routes:      components.flatMap(\.routes)
        )
    }
    static func buildOptional(_ c: OfflineMapContentGroup?) -> OfflineMapContentGroup {
        c ?? OfflineMapContentGroup(annotations: [], routes: [])
    }
    static func buildEither(first:  OfflineMapContentGroup) -> OfflineMapContentGroup { first }
    static func buildEither(second: OfflineMapContentGroup) -> OfflineMapContentGroup { second }
    static func buildArray(_ cs: [OfflineMapContentGroup]) -> OfflineMapContentGroup {
        OfflineMapContentGroup(annotations: cs.flatMap(\.annotations), routes: cs.flatMap(\.routes))
    }
}

extension OfflineAnnotation: OfflineMapContent {
    var annotations: [OfflineAnnotation] { [self] }
    var routes: [OfflineRoute] { [] }
}
extension OfflineRoute: OfflineMapContent {
    var annotations: [OfflineAnnotation] { [] }
    var routes: [OfflineRoute] { [self] }
}

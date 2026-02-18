//
//  MapContent.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 18/2/26.
//

import CoreLocation

protocol OfflineMapContent {
    var annotations: [OfflineAnnotation] { get }
    var routes:      [OfflineRoute]      { get }
}

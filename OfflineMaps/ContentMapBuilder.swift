//
//  ContentMapBuilder.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 18/2/26.
//

import Foundation

struct OfflineMapContentGroup: OfflineMapContent {
    var annotations: [OfflineAnnotation]
    var routes:      [OfflineRoute]
}

//
//  MSeriesCheck.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 6/12/25.
//

import Foundation
import SwiftUI

/// Read the device model identifier (e.g. "iPad16,3")
func deviceModelIdentifier() -> String {
    var sys = utsname()
    uname(&sys)
    let mirror = Mirror(reflecting: sys.machine)
    let id = mirror.children.compactMap { $0.value as? Int8 }
                     .prefix(while: { $0 != 0 })
                     .map { String(UnicodeScalar(UInt8($0))) }
                     .joined()
    return id
}

struct DeviceInfo {
    /// Known M-series iPad model identifiers (M1..M5). Update this set when Apple ships new models.
    static let mSeriesModelIDs: Set<String> = [
        // iPads
        // M1
        "iPad13,4","iPad13,5","iPad13,6","iPad13,7",
        "iPad13,8","iPad13,9","iPad13,10","iPad13,11",
        // M2
        "iPad14,3","iPad14,4","iPad14,5","iPad14,6",
        // M3
        "iPad15,3","iPad15,4","iPad15,5","iPad15,6",
        // M4
        "iPad16,3","iPad16,4","iPad16,5","iPad16,6",
        // M5
        "iPad17,1","iPad17,2","iPad17,3","iPad17,4",
        
        // Macs
        // M2
        "Mac14,5", "Mac14,6",   // MBP 14/16 (M2 Pro/Max)
        "Mac14,9", "Mac14,10",  // MBP 14/16 (M2 Pro/Max)
        "Mac14,12",             // Mac Mini (M2 Pro)
        "Mac14,13", "Mac14,14", // Mac Studio (M2 Max/Ultra)
        
        // M3 Pro & Max (MBP 14" & 16")
        "Mac15,6", "Mac15,7", "Mac15,8", "Mac15,9", "Mac15,10", "Mac15,11",
        
        // M4 Pro & Max (MBP, Mac Studio, Mac Mini)
        "Mac16,5", "Mac16,6",   // MBP 14/16 (M4 Pro)
        "Mac16,7", "Mac16,8",   // MBP 14/16 (M4 Max)
        "Mac16,9", "Mac16,11",  // Mac Studio / Mac Mini (M4 Pro)
        
        // M5 series (Early 2026 releases)
        "Mac17,5", "Mac17,6", "Mac17,9", "Mac17,10",
        
        // SPECIAL DEBUG STUB FOR VM TESTING
        "VirtualMac2,1",
    ]

    /// True if the current device matches a known M-series iPad model identifier.
    static var isMSeriesIPad: Bool {
        let id = deviceModelIdentifier()
        return mSeriesModelIDs.contains(id)
    }

    /// Convenience: returns the raw model identifier and whether it's M-series.
    static var modelAndIsMSeries: (modelIdentifier: String, isMSeries: Bool) {
        let id = deviceModelIdentifier()
        return (id, mSeriesModelIDs.contains(id))
    }
}

//
//  OfflineMapsCalloutManager.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 18/2/26.
//

import Foundation
import CoreLocation
import SwiftUI

extension _OfflineMapRenderer {
    func calloutView(for ann: OfflineAnnotation) -> some View {
        VStack(spacing: 4) {
            switch ann.kind {
            case .airport(let iata, let icao, let name, let city, let country, let isHub):
                HStack(spacing: 6) {
                    Text(iata)
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                        .foregroundColor(isHub ? hubColor : airportColor)
                    Text("·")
                        .foregroundColor(.white.opacity(0.3))
                    Text(icao)
                        .font(.system(size: 12, weight: .medium, design: .monospaced))
                        .foregroundColor(.white.opacity(0.55))
                }
                Text(name)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(.white.opacity(0.85))
                    .fontWidth(.condensed)
                    .multilineTextAlignment(.center)
                Text("\(city), \(country)")
                    .font(.system(size: 10))
                    .foregroundColor(.white.opacity(0.5))
                    .fontWidth(.condensed)
                if isHub {
                    Text("HUB")
                        .font(.system(size: 9, weight: .heavy))
                        .fontWidth(.expanded)
                        .foregroundColor(hubColor)
                        .padding(.horizontal, 6).padding(.vertical, 2)
                        .background(hubColor.opacity(0.15))
                        .clipShape(Capsule())
                }

            case .aircraft(let reg, let airborne, _):
                Text(reg)
                    .font(.system(size: 13, weight: .bold, design: .monospaced))
                    .foregroundColor(airborne ? aircraftColor : .white.opacity(0.6))
                    .fontWidth(.expanded)
                Text(airborne ? "In flight" : "On ground")
                    .font(.system(size: 11))
                    .foregroundColor(.white.opacity(0.7))
                    .fontWidth(.condensed)
            }
        }
        .padding(.horizontal, 14).padding(.vertical, 10)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.12), lineWidth: 1))
        .shadow(color: .black.opacity(0.4), radius: 8)
    }
}

//
//  CalloutManager.swift
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
            case .airport(let iata, let name, let isHub):
                Text(iata)
                    .font(.system(size: 13, weight: .bold, design: .monospaced))
                    .foregroundColor(isHub ? hubColor : airportColor)
                Text(name)
                    .font(.system(size: 11))
                    .foregroundColor(.white.opacity(0.8))
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
            case .aircraft(let reg, let airborne):
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
        .padding(.horizontal, 12).padding(.vertical, 8)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white.opacity(0.12), lineWidth: 1))
        .shadow(color: .black.opacity(0.4), radius: 8)
    }
}

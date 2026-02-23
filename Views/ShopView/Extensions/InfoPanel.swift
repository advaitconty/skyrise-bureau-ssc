//
//  InfoPanel.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 17/2/26.
//

import SwiftUI

extension ShopView {
    func infoPanel(_ plane: Aircraft) -> some View {
        VStack {
            HStack {
                Text(plane.name)
                    .font(.system(size: 36))
                    .fontWidth(.expanded)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
            HStack {
                Text(plane.description)
                    .font(.system(size: 16))
                    .fontWidth(.condensed)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
            
            
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 150), spacing: 10)
            ], spacing: 10) {
                littleSmallBoxThingyForMainView(icon: "ruler", item: "\(plane.maxRange)km")
                littleSmallBoxThingyForMainView(icon: "gauge.with.dots.needle.33percent", item: "\(plane.cruiseSpeed)km/h")
                littleSmallBoxThingyForMainView(icon: "carseat.right.fill", item: "\(plane.maxSeats)")
                littleSmallBoxThingyForMainView(icon: "fuelpump", item: "\(plane.fuelBurnRate)L/km")
                littleSmallBoxThingyForMainView(icon: "road.lanes", item: "\(plane.minRunwayLength)m")
                littleSmallBoxThingyForMainView(icon: "dollarsign.circle", item: "$\(plane.maintenanceCostPerHour)/km")
            }
            
            
            VStack {
                HStack {
                    Text("Normal seating arrangement")
                        .fontWidth(.condensed)
                    Spacer()
                }
                HStack {
                    Image(systemName: "carseat.right")
                        .font(.system(size: 12))
                    Text("\(plane.defaultSeating.economy)")
                        .font(.system(size: 12))
                        .fontWidth(.condensed)
                    Divider()
                    Image(systemName: "star")
                        .font(.system(size: 12))
                    Text("\(plane.defaultSeating.premiumEconomy)")
                        .font(.system(size: 12))
                        .fontWidth(.condensed)
                    Divider()
                    Image(systemName: "briefcase")
                        .font(.system(size: 12))
                    Text("\(plane.defaultSeating.business)")
                        .font(.system(size: 12))
                        .fontWidth(.condensed)
                    Divider()
                    Image(systemName: "crown")
                        .font(.system(size: 12))
                    Text("\(plane.defaultSeating.first)")
                        .font(.system(size: 12))
                        .fontWidth(.condensed)
                }
            }
            .frame(maxWidth: 250, maxHeight: 50)
            .padding()
            .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Normal seating: \(plane.defaultSeating.economy) economy, \(plane.defaultSeating.premiumEconomy) premium economy, \(plane.defaultSeating.business) business, \(plane.defaultSeating.first) first class")
        }
    }

}

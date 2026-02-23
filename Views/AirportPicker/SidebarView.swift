//
//  SidebarView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 8/12/25.
//

import SwiftUI

extension AirportPickerView {
    func sidebarView(height: CGFloat) -> some View {
        VStack {
            ScrollView {
                ForEach(filteredAirports, id: \.uniqueID) { airport in
                    if airport == airportSelected {
                        Button {
                            withAnimation {
                                airportSelected = airport
                            }
                        } label: {
                            VStack {
                                HStack {
                                    Text(airport.name)
                                        .font(.title)
                                        .fontWidth(.expanded)
                                    Spacer()
                                }
                                HStack {
                                    Text("\(airport.iata) (\(airport.icao))")
                                        .fontWidth(.condensed)
                                    Spacer()
                                    Text(airport.region.rawValue)
                                        .fontWidth(.condensed)
                                }
                                HStack {
                                    Text("Max Runway length: \(airport.runwayLength.withCommas)m")
                                        .fontWidth(.condensed)
                                    Spacer()
                                    Text("Elevation: \(airport.elevation)m")
                                        .fontWidth(.condensed)
                                }
                            }
                            .foregroundStyle(Color.white)
                            .padding()
                            .background(Color.accentColor)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        }
                        .buttonStyle(.plain)
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("\(airport.name), \(airport.iata), \(airport.region.rawValue), runway \(airport.runwayLength.withCommas) meters, elevation \(airport.elevation) meters")
                        .accessibilityAddTraits(.isSelected)
                    } else {
                        Button {
                            withAnimation {
                                airportSelected = airport
                            }
                        } label: {
                            VStack {
                                HStack {
                                    Text(airport.name)
                                        .font(.title)
                                        .fontWidth(.expanded)
                                    Spacer()
                                }
                                HStack {
                                    Text("\(airport.iata) (\(airport.icao))")
                                        .fontWidth(.condensed)
                                    Spacer()
                                    Text(airport.region.rawValue)
                                        .fontWidth(.condensed)
                                }
                                HStack {
                                    Text("Max Runway length: \(airport.runwayLength.withCommas)m")
                                        .fontWidth(.condensed)
                                    Spacer()
                                    Text("Elevation: \(airport.elevation)m")
                                        .fontWidth(.condensed)
                                }
                            }
                            .padding()
                            .background(.ultraThickMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        }
                        .buttonStyle(.plain)
                        .hoverEffect()
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("\(airport.name), \(airport.iata), \(airport.region.rawValue), runway \(airport.runwayLength.withCommas) meters, elevation \(airport.elevation) meters")
                        .accessibilityHint("Double tap to select this airport")
                    }
                }
            }
            HStack {
                Image(systemName: "location.magnifyingglass")
                TextField("Search for airports...", text: $searchTerm)
                    .fontWidth(.condensed)
                    .accessibilityLabel("Search airports")
            }
            .padding()
            .glassEffect()
            .accessibilityElement(children: .contain)
        }
        .padding()
        .frame(width: CGFloat(300), height: height - 30)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
    }
}

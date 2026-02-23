//
//  HubAirportView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 20/11/25.
//

import SwiftUI

extension UserUpgradeView {
    func airportItemView(_ airport: Airport) -> some View {
        VStack {
            Text("\(countryNameToEmoji(airport.country))\(airport.iata) (\(airport.icao))\n")
                .fontWidth(.expanded)
            +
            Text(airport.name)
                .fontWidth(.condensed)
        }
        .padding()
        .frame(width: 200, height: 150)
        .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Hub airport: \(airport.name), \(airport.iata)")
    }
    
    func hubAirportsView() -> some View {
        VStack {
            HStack {
                Text("\(modifiableUserData.wrappedValue.deliveryHubs.count) Hub airports owned".uppercased())
                    .fontWidth(.expanded)
                Spacer()
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(modifiableUserData.wrappedValue.deliveryHubs, id: \.uniqueID) { airport in
                        airportItemView(airport)
                    }
                    Button {
                        withAnimation {
                            showAirportPickerView = false
                        }
                        modifiableUserData.wrappedValue.amountSpentOnHubsAccquisitionInTheLastWeek[-1] = modifiableUserData.wrappedValue.amountSpentOnHubsAccquisitionInTheLastWeek[-1] + 10000000
                    } label: {
                        VStack {
                            Text("New hub airport")
                                .fontWidth(.expanded)
                            Image(systemName: "plus")
                                .font(.system(size: 24))
                                .padding(1)
                            Text("$10,000,000")
                                .fontWidth(.condensed)
                            if modifiableUserData.wrappedValue.accountBalance < 10000000 {
                                Text("Not enough for a new hub")
                                    .fontWidth(.condensed)
                            }
                        }
                        .padding()
                        .frame(width: 200, height: 150)
                        .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    }
                    .buttonStyle(.plain)
                    .disabled(modifiableUserData.wrappedValue.accountBalance < 10000000)
                    .hoverEffect()
                    .accessibilityLabel("Purchase new hub airport for 10 million dollars")
                    .accessibilityHint(modifiableUserData.wrappedValue.accountBalance < 10000000 ? "Not enough funds" : "Double tap to select a hub airport")
                }
            }
        }
    }
}

//
//  AirportPicker.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 17/2/26.
//

import SwiftUI

extension ShopView {
    func availableAirportPicker() -> some View {
        VStack {
                Text("Delivery Airport")
                    .fontWidth(.expanded)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(modifiableUserData.deliveryHubs, id: \.uniqueID) { airport in
                        if airportToDeliverPlaneTo == airport.wrappedValue {
                            Button {
                                withAnimation {
                                    airportToDeliverPlaneTo = airport.wrappedValue
                                }
                            } label: {
                                Text("\(countryNameToEmoji(airport.wrappedValue.country)) \(airport.wrappedValue.reportCorrectCodeForUserData(modifiableUserData.wrappedValue))")
                                    .fontWidth(.expanded)
                            }
                            .buttonStyle(.borderedProminent)
                            .transition(.blurReplace)
                        } else {
                            Button {
                                withAnimation {
                                    airportToDeliverPlaneTo = airport.wrappedValue
                                }
                            } label: {
                                Text("\(countryNameToEmoji(airport.wrappedValue.country)) \(airport.wrappedValue.reportCorrectCodeForUserData(modifiableUserData.wrappedValue))")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.bordered)
                            .transition(.blurReplace)
                        }
                    }
                }
            }
        }
        .onAppear {
            airportToDeliverPlaneTo = modifiableUserData.deliveryHubs.wrappedValue[0]
        }
        .padding()
        .background(
            colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
    }
}

//
//  UserUpgradeView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 20/11/25.
//

import SwiftUI
import SwiftData

extension View {
    @ViewBuilder
    func adaptiveProminentButtonStyle() -> some View {
        if #available(iOS 26.0, *) {
            self.buttonStyle(.glassProminent)
        } else {
            self.buttonStyle(.borderedProminent)
        }
    }
}

extension View {
    @ViewBuilder
    func adaptiveButtonStyle() -> some View {
        if #available(iOS 26.0, *) {
            self.buttonStyle(.glass)
        } else {
            self.buttonStyle(.bordered)
        }
    }
}

struct UserUpgradeView: View {
    @State var showAirportPickerView: Bool = true
    @State var selectedAirport: Airport = Airport(
        name: "Soote",
        city: "Dubai",
        country: "United Arab Emirates",
        iata: "DXB",
        icao: "OMDB",
        region: .asia,
        latitude: 25.2532,
        longitude: 55.3657,
        runwayLength: 4000,
        elevation: 19,
        demand: AirportDemand(passengerDemand: 10.0, cargoDemand: 9.0, businessTravelRatio: 0.78, tourismBoost: 0.88),
        facilities: AirportFacilities(terminalCapacity: 230000, cargoCapacity: 4800, gatesAvailable: 120, slotEfficiency: 0.94)
    )
    @Environment(\.dismissWindow) var dismissWindow
    @Environment(\.dismiss) var dismiss
    @Query var userData: [UserData]
    @Environment(\.modelContext) var modelContext
    var modifiableUserData: Binding<UserData>
    /// Debug stuff
    /// Keep in case above binding decides to cause problems again
    /// stupid bindings
    //    var userData: Binding<UserData> {
    //        Binding {
    //            return testUserData
    //        } set: { value in
    //            testUserData = value
    //        }
    //    }
    
    @State var screen: Int = 1
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            if !showAirportPickerView {
                AirportPickerView(airportSelected: $selectedAirport, userData: modifiableUserData.wrappedValue, finishedPickingScreen: $showAirportPickerView)
                    .transition(.move(edge: .leading))
                    .padding()
            } else {
                VStack {
                    HStack {
                        VStack {
                            HStack {
                                HStack {
                                    Image(systemName: "pencil.line")
                                        .font(.title)
                                        .accessibilityHidden(true)
                                    TextField(modifiableUserData.wrappedValue.airlineName, text: modifiableUserData.airlineName)
                                        .textFieldStyle(.plain)
                                        .font(.largeTitle)
                                        .fontWidth(.expanded)
                                        .fixedSize()
                                        .accessibilityLabel("Airline name")
                                }
                                Spacer()
                            }
                            HStack(spacing: 0) {
                                Text("As managed by ".uppercased())
                                    .font(.caption2)
                                    .fontWidth(.expanded)
                                HStack {
                                    Image(systemName: "pencil.line")
                                        .accessibilityHidden(true)
                                    TextField(modifiableUserData.wrappedValue.name, text: modifiableUserData.name)
                                        .textFieldStyle(.plain)
                                        .font(.caption2)
                                        .fontWidth(.expanded)
                                        .fixedSize()
                                        .accessibilityLabel("CEO name")
                                        .fontWidth(.expanded)
                                        .fixedSize()
                                }
                                Spacer()
                            }
                            HStack {
                                Text("ACTIVE RESERVES: $\(modifiableUserData.wrappedValue.accountBalance.withCommas)".uppercased())
                                    .font(.caption2)
                                    .fontWidth(.expanded)
                                    .contentTransition(.numericText(countsDown: true))
                                    .accessibilityLabel("Active reserves: \(modifiableUserData.wrappedValue.accountBalance.withCommas) dollars")
                                Spacer()
                            }
                        }
                        Text("\(modifiableUserData.wrappedValue.xpPoints)")
                            .fontWidth(.expanded)
                            .font(.largeTitle)
                            .accessibilityLabel("\(modifiableUserData.wrappedValue.xpPoints) available XP points")
                        Text("AVAILABLE\nXP POINTS")
                            .fontWidth(.expanded)
                            .accessibilityHidden(true)
                        //                        if !checkForMacCatalyst() {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                        .adaptiveButtonStyle()
                        .hoverEffect()
                        .accessibilityLabel("Close airline management")
                    }
                    HStack {
                        if screen == 1 {
                            Button {
                                withAnimation(.smooth, completionCriteria: .removed) {
                                    screen = 1
                                } completion: {
                                    print("Screen changed")
                                }
                            } label: {
                                Spacer()
                                Text("YOUR AIRLINE")
                                    .fontWidth(.expanded)
                                    .font(.caption)
                                Spacer()
                            }
                            .adaptiveProminentButtonStyle()
                            .hoverEffect()
                        } else {
                            Button {
                                withAnimation(.smooth, completionCriteria: .removed) {
                                    screen = 1
                                } completion: {
                                    print("Screen changed")
                                }
                            } label: {
                                Spacer()
                                Text("YOUR AIRLINE")
                                    .fontWidth(.expanded)
                                    .font(.caption)
                                Spacer()
                            }
                            .adaptiveButtonStyle()
                            .hoverEffect()
                        }
                        
                        if screen == 2 {
                            Button {
                                withAnimation(.snappy(duration: 0.75), completionCriteria: .removed) {
                                    screen = 2
                                } completion: {
                                    print("Screen changed")
                                }
                            } label: {
                                Spacer()
                                Text("REPUTATION")
                                    .fontWidth(.expanded)
                                    .font(.caption)
                                Spacer()
                            }
                            .adaptiveProminentButtonStyle()
                            .hoverEffect()
                        } else {
                            Button {
                                withAnimation(.snappy(duration: 0.75), completionCriteria: .removed) {
                                    screen = 2
                                } completion: {
                                    print("Screen changed")
                                }
                            } label: {
                                Spacer()
                                Text("REPUTATION")
                                    .fontWidth(.expanded)
                                    .font(.caption)
                                Spacer()
                            }
                            .adaptiveButtonStyle()
                            .hoverEffect()
                        }
                            
                        if screen == 3 {
                            Button {
                                withAnimation(.snappy(duration: 0.75), completionCriteria: .removed) {
                                    screen = 3
                                } completion: {
                                    print("Screen changed")
                                }
                            } label: {
                                Spacer()
                                Text("UPGRADES")
                                    .fontWidth(.expanded)
                                    .font(.caption)
                                Spacer()
                            }
                            .adaptiveProminentButtonStyle()
                            .hoverEffect()
                        } else {
                            Button {
                                withAnimation(.snappy(duration: 0.75), completionCriteria: .removed) {
                                    screen = 3
                                } completion: {
                                    print("Screen changed")
                                }
                            } label: {
                                Spacer()
                                Text("UPGRADES")
                                    .fontWidth(.expanded)
                                    .font(.caption)
                                Spacer()
                            }
                            .adaptiveButtonStyle()
                            .hoverEffect()
                        }
                        
                        if screen == 4 {
                            Button {
                                withAnimation(.snappy(duration: 0.75), completionCriteria: .removed) {
                                    screen = 4
                                } completion: {
                                    print("Screen changed")
                                }
                            } label: {
                                Spacer()
                                Text("FINANCES")
                                    .fontWidth(.expanded)
                                    .font(.caption)
                                Spacer()
                            }
                            .adaptiveProminentButtonStyle()
                            .hoverEffect()
                        } else {
                            Button {
                                withAnimation(.snappy(duration: 0.75), completionCriteria: .removed) {
                                    screen = 4
                                } completion: {
                                    print("Screen changed")
                                }
                            } label: {
                                Spacer()
                                Text("FINANCES")
                                    .fontWidth(.expanded)
                                    .font(.caption)
                                Spacer()
                            }
                            .adaptiveButtonStyle()
                            .hoverEffect()
                        }
                    }
                    if screen == 1 {
                        ScrollView {
                            /// This is gonna be a v2 feature, will be a non-issue
                            paycheckView()
                            
                            // MARK: Airline Stats Start
                            HStack {
                                Text("AIRLINE INFO")
                                    .font(.title2)
                                    .fontWidth(.expanded)
                                Spacer()
                            }
                            // Hub airports
                            hubAirportsView()
                            
                            // Planes
                            planeStatsViewForUpgrades()
                        }
                        .transition(.asymmetric(insertion: .slide, removal: .opacity))
                    } else if screen == 2 {
                        reputationView()
                            .transition(.asymmetric(insertion: .slide, removal: .opacity))
                    } else if screen == 3 {
                        upgradeView()
                            .transition(.asymmetric(insertion: .slide, removal: .opacity))
                    } else if screen == 4 {
                        financesView()
                            .transition(.asymmetric(insertion: .slide, removal: .opacity))
                    }
                }
                .padding()
                .transition(.move(edge: .leading))
            }
        }
        .onChange(of: showAirportPickerView) { oldValue, newValue in
            if !oldValue && newValue && AirportDatabase.shared.allAirports.contains(where: {selectedAirport.name == $0.name}) {
                withAnimation {
                    modifiableUserData.wrappedValue.deliveryHubs.append(selectedAirport)
                    modifiableUserData.wrappedValue.accountBalance -= 10000000
                }
                selectedAirport = Airport(
                    name: "Soote",
                    city: "Dubai",
                    country: "United Arab Emirates",
                    iata: "DXB",
                    icao: "OMDB",
                    region: .asia,
                    latitude: 25.2532,
                    longitude: 55.3657,
                    runwayLength: 4000,
                    elevation: 19,
                    demand: AirportDemand(passengerDemand: 10.0, cargoDemand: 9.0, businessTravelRatio: 0.78, tourismBoost: 0.88),
                    facilities: AirportFacilities(terminalCapacity: 230000, cargoCapacity: 4800, gatesAvailable: 120, slotEfficiency: 0.94)
                )
            }
        }
    }
}

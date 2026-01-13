//
//  UserUpgradeView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 20/11/25.
//

import SwiftUI
import SwiftData

struct UserUpgradeView: View {
    @Environment(\.dismissWindow) private var dismissWindow
    @EnvironmentObject var windowsOpened: WindowRegistry
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
    @Query var swiftDataUserData: [UserData]
    @Environment(\.modelContext) var modelContext
    var userData: Binding<UserData> {
        Binding {
            return swiftDataUserData.first ?? UserData(name: "Advait",
                                                       airlineName: "IndiGo Atlantic",
                                                       airlineIataCode: "6E",
                                                       planes: [
                                                           FleetItem(aircraftID: "IL96-400M",
                                                                     aircraftname: "Suka Blyat",
                                                                     registration: "VT-SBL",
                                                                     hoursFlown: 3,
                                                                     assignedRoute: Route(originAirport: Airport(
                                                                       name: "Adolfo Suárez Madrid-Barajas Airport",
                                                                       city: "Madrid",
                                                                       country: "Spain",
                                                                       iata: "MAD",
                                                                       icao: "LEMD",
                                                                       region: .europe,
                                                                       latitude: 40.4719,
                                                                       longitude: -3.5626,
                                                                       runwayLength: 4179,
                                                                       elevation: 610,
                                                                       demand: AirportDemand(passengerDemand: 8.8, cargoDemand: 7.8, businessTravelRatio: 0.65, tourismBoost: 0.88),
                                                                       facilities: AirportFacilities(terminalCapacity: 165000, cargoCapacity: 3000, gatesAvailable: 90, slotEfficiency: 0.88)
                                                                     ), arrivalAirport: Airport(
                                                                       name: "London Heathrow Airport",
                                                                       city: "London",
                                                                       country: "United Kingdom",
                                                                       iata: "LHR",
                                                                       icao: "EGLL",
                                                                       region: .europe,
                                                                       latitude: 51.4700,
                                                                       longitude: -0.4543,
                                                                       runwayLength: 3902,
                                                                       elevation: 25,
                                                                       demand: AirportDemand(passengerDemand: 10.0, cargoDemand: 8.8, businessTravelRatio: 0.80, tourismBoost: 0.85),
                                                                       facilities: AirportFacilities(terminalCapacity: 225000, cargoCapacity: 3800, gatesAvailable: 115, slotEfficiency: 0.93)
                                                                     )),
                                                                     seatingLayout: SeatingConfig(economy: 258, premiumEconomy: 54, business: 28, first: 6),
                                                                     kilometersTravelledSinceLastMaintainence: 3200,
                                                                     currentAirportLocation: Airport(
                                                                       name: "Adolfo Suárez Madrid-Barajas Airport",
                                                                       city: "Madrid",
                                                                       country: "Spain",
                                                                       iata: "MAD",
                                                                       icao: "LEMD",
                                                                       region: .europe,
                                                                       latitude: 40.4719,
                                                                       longitude: -3.5626,
                                                                       runwayLength: 4179,
                                                                       elevation: 610,
                                                                       demand: AirportDemand(passengerDemand: 8.8, cargoDemand: 7.8, businessTravelRatio: 0.65, tourismBoost: 0.88),
                                                                       facilities: AirportFacilities(terminalCapacity: 165000, cargoCapacity: 3000, gatesAvailable: 90, slotEfficiency: 0.88)
                                                                     )),
                                                           FleetItem(aircraftID: "IL96-400M",
                                                                     aircraftname: "Babushka",
                                                                     registration: "VT-SBT",
                                                                     hoursFlown: 3,
                                                                     seatingLayout: SeatingConfig(economy: 258, premiumEconomy: 54, business: 28, first: 6),
                                                                     kilometersTravelledSinceLastMaintainence: 3200,
                                                                     currentAirportLocation: Airport(
                                                                       name: "Adolfo Suárez Madrid-Barajas Airport",
                                                                       city: "Madrid",
                                                                       country: "Spain",
                                                                       iata: "MAD",
                                                                       icao: "LEMD",
                                                                       region: .europe,
                                                                       latitude: 40.4719,
                                                                       longitude: -3.5626,
                                                                       runwayLength: 4179,
                                                                       elevation: 610,
                                                                       demand: AirportDemand(passengerDemand: 8.8, cargoDemand: 7.8, businessTravelRatio: 0.65, tourismBoost: 0.88),
                                                                       facilities: AirportFacilities(terminalCapacity: 165000, cargoCapacity: 3000, gatesAvailable: 90, slotEfficiency: 0.88)
                                                                     )),
                                                           FleetItem(aircraftID: "IL96-400M",
                                                                     aircraftname: "Karthoshka",
                                                                     registration: "VT-SVT",
                                                                     hoursFlown: 3,
                                                                     seatingLayout: SeatingConfig(economy: 258, premiumEconomy: 54, business: 28, first: 6),
                                                                     kilometersTravelledSinceLastMaintainence: 3200,
                                                                     currentAirportLocation: Airport(
                                                                       name: "Stockholm Arlanda Airport",
                                                                       city: "Stockholm",
                                                                       country: "Sweden",
                                                                       iata: "ARN",
                                                                       icao: "ESSA",
                                                                       region: .europe,
                                                                       latitude: 59.6498,
                                                                       longitude: 17.9238,
                                                                       runwayLength: 3301,
                                                                       elevation: 42,
                                                                       demand: AirportDemand(passengerDemand: 8.4, cargoDemand: 7.5, businessTravelRatio: 0.70, tourismBoost: 0.78),
                                                                       facilities: AirportFacilities(terminalCapacity: 155000, cargoCapacity: 2800, gatesAvailable: 75, slotEfficiency: 0.89)
                                                                     ))
                                                       ],
                                                       xp: 250,
                                                       xpPoints: 8,
                                                       levels: 8,
                                                       airlineReputation: 0.8,
                                                       reliabilityIndex: 0.76,
                                                       fuelDiscountMultiplier: 0.99,
                                                       lastFuelPrice: 900,
                                                       pilots: 9,
                                                       flightAttendents: 27,
                                                       maintainanceCrew: 12,
                                                       currentlyHoldingFuel: 3_000_000,
                                                       maxFuelHoldable: 5_000_000,
                                                       weeklyPilotSalary: 500,
                                                       weeklyFlightAttendentSalary: 400,
                                                       weeklyFlightMaintainanceCrewSalary: 350,
                                                       pilotHappiness: 0.98,
                                                       flightAttendentHappiness: 0.97,
                                                       maintainanceCrewHappiness: 0.96,
                                                       campaignRunning: false,
                                                       deliveryHubs: [
                                                           Airport(
                                                               name: "Stockholm Arlanda Airport",
                                                               city: "Stockholm",
                                                               country: "Sweden",
                                                               iata: "ARN",
                                                               icao: "ESSA",
                                                               region: .europe,
                                                               latitude: 59.6498,
                                                               longitude: 17.9238,
                                                               runwayLength: 3301,
                                                               elevation: 42,
                                                               demand: AirportDemand(passengerDemand: 8.4, cargoDemand: 7.5, businessTravelRatio: 0.70, tourismBoost: 0.78),
                                                               facilities: AirportFacilities(terminalCapacity: 155000, cargoCapacity: 2800, gatesAvailable: 75, slotEfficiency: 0.89)
                                                           ),
                                                           Airport(
                                                               name: "Adolfo Suárez Madrid-Barajas Airport",
                                                               city: "Madrid",
                                                               country: "Spain",
                                                               iata: "MAD",
                                                               icao: "LEMD",
                                                               region: .europe,
                                                               latitude: 40.4719,
                                                               longitude: -3.5626,
                                                               runwayLength: 4179,
                                                               elevation: 610,
                                                               demand: AirportDemand(passengerDemand: 8.8, cargoDemand: 7.8, businessTravelRatio: 0.65, tourismBoost: 0.88),
                                                               facilities: AirportFacilities(terminalCapacity: 165000, cargoCapacity: 3000, gatesAvailable: 90, slotEfficiency: 0.88)
                                                           )], accountBalance: 100_000_000)
        } set: { value in
            if let item = swiftDataUserData.first {
                item.planes = value.planes
                item.deliveryHubs = value.deliveryHubs
                item.airlineIataCode = value.airlineIataCode
                item.airlineName = value.airlineName
                item.name = value.name
                item.accountBalance = value.accountBalance
                item.airlineReputation = value.airlineReputation
                item.campaignEffectiveness = value.campaignEffectiveness
                item.campaignRunning = value.campaignRunning
                item.currentlyHoldingFuel = value.currentlyHoldingFuel
                item.flightAttendentHappiness = value.flightAttendentHappiness
                item.flightAttendents = value.flightAttendents
                item.fuelDiscountMultiplier = value.fuelDiscountMultiplier
                item.lastFuelPrice = value.lastFuelPrice
                item.levels = value.levels
                item.maintainanceCrew = value.maintainanceCrew
                item.maintainanceCrewHappiness = value.maintainanceCrewHappiness
                item.maxFuelHoldable = value.maxFuelHoldable
                item.pilotHappiness = value.pilotHappiness
                item.pilots = value.pilots
                item.pilotHappiness = value.pilotHappiness
                item.xp = value.xp
                
                try? modelContext.save()
            }
        }
    }
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
                AirportPickerView(airportText: "Please select your new hub airport", maxRange: 0, startAirport: nil, moveOn: $showAirportPickerView, finalAirportSelected: $selectedAirport, disallowedAirports: userData.wrappedValue.deliveryHubs, userData: userData.wrappedValue)
                    .transition(.move(edge: .leading))
                    .padding()
            } else {
                VStack {
                    HStack {
                        VStack {
                            HStack {
                                TextField(userData.wrappedValue.airlineName, text: userData.airlineName)
                                    .textFieldStyle(.plain)
                                    .font(.largeTitle)
                                    .fontWidth(.expanded)
                                Spacer()
                            }
                            HStack(spacing: 0) {
                                Text("As managed by ".uppercased())
                                    .font(.caption2)
                                    .fontWidth(.expanded)
                                TextField(userData.wrappedValue.name, text: userData.name)
                                    .textFieldStyle(.plain)
                                    .font(.caption2)
                                    .fontWidth(.expanded)
                                Spacer()
                            }
                            HStack {
                                Text("ACTIVE RESERVES: $\(userData.wrappedValue.accountBalance.withCommas)".uppercased())
                                    .font(.caption2)
                                    .fontWidth(.expanded)
                                    .contentTransition(.numericText(countsDown: true))
                                Spacer()
                            }
                        }
                        Text("\(userData.wrappedValue.xpPoints)")
                            .fontWidth(.expanded)
                            .font(.largeTitle)
                        Text("AVAILABLE\nXP POINTS")
                            .fontWidth(.expanded)
                    }
                    HStack {
                        Button {
                            withAnimation(.smooth, completionCriteria: .removed) {
                                screen = 1
                            } completion: {
                                print("Screen changed")
                            }
                        } label: {
                            Spacer()
                            Text("SALARY AND HUBS")
                                .fontWidth(.expanded)
                                .font(.caption)
                            Spacer()
                        }
                        .adaptiveProminentButtonStyle()
                        .tint(screen == 1 ? .accentColor : .gray)
                        
                        
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
                        .tint(screen == 2 ? .accentColor : .gray)
                        
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
                        .tint(screen == 3 ? .accentColor : .gray)
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
                    }
                }
                .padding()
                .transition(.move(edge: .leading))
            }
        }
        .onChange(of: showAirportPickerView) { oldValue, newValue in
            if !oldValue && newValue && AirportDatabase.shared.allAirports.contains(where: {selectedAirport.name == $0.name}) {
                withAnimation {
                    userData.wrappedValue.deliveryHubs.append(selectedAirport)
                    userData.wrappedValue.accountBalance -= 10000000
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
        .frame(width: 600, height: 400)
        .onAppear {
            windowsOpened.windowsOpened.append(.attributes)
            
            print(windowsOpened.windowsOpened.count(where: { $0 == .attributes }))

            if windowsOpened.windowsOpened.count(where: { $0 == .attributes }) >= 2 {
                dismissWindow()
            }
        }
        .onDisappear {
            windowsOpened.windowsOpened.remove(at: windowsOpened.windowsOpened.firstIndex(where: { $0 == .attributes})!)
        }
    }
}

#Preview {
    UserUpgradeView()
}

//
//  ContentView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/11/25.
//

import SwiftUI
import SwiftData
import Foundation
import Combine

struct ContentView: View {
    var moidifiableUserdata: Binding<UserData> {
        Binding {
            userData.first ?? UserData(name: "Advait",
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
            if let item = userData.first {
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
                print("saving userdata...")
                try? modelContext.save()
                print("saved userdata successfully")
            }
        }
    }
    @Environment(\.modelContext) var modelContext
    @Query var userData: [UserData]
    @State var showFinancialsAvailableAlert: Bool = false
    let planeArrivalTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let fuelPriceTimer = Timer.publish(every: 7200, on: .main, in: .common).autoconnect() // 2 hours
    var resetUserData: Bool
    var useTestData: DataTypeToUse
    var body: some View {
        VStack {
            MapView(userData: moidifiableUserdata)
                .onAppear {
                    /// Test stubs
                    if resetUserData {
                        for item in userData {
                            modelContext.delete(item)
                        }
                        try? modelContext.save()
                    } else if useTestData != .none {
                        var value: UserData
                        print("SKIPPING TEST DATA IMPLEMENTATION IN THIS CODE")
                        print("Swift Playgrounds cannot keep test data code as mainActor")
                        if useTestData == .flyingPlanes {
//                            value = testUserDataWithFlyingPlanes
                            print("Flying planes test data used")
                        } else if useTestData == .regular {
//                            value = testUserData
                            print("Regular test data used")
                        } else {
//                            value = testUserDataEndgame
                            print("Endgame test user data being used")
                        }
//                        if let item = userData.first {
//                            item.planes = value.planes
//                            item.deliveryHubs = value.deliveryHubs
//                            item.airlineIataCode = value.airlineIataCode
//                            item.airlineName = value.airlineName
//                            item.name = value.name
//                            item.accountBalance = value.accountBalance
//                            item.airlineReputation = value.airlineReputation
//                            item.campaignEffectiveness = value.campaignEffectiveness
//                            item.campaignRunning = value.campaignRunning
//                            item.currentlyHoldingFuel = value.currentlyHoldingFuel
//                            item.flightAttendentHappiness = value.flightAttendentHappiness
//                            item.flightAttendents = value.flightAttendents
//                            item.fuelDiscountMultiplier = value.fuelDiscountMultiplier
//                            item.lastFuelPrice = value.lastFuelPrice
//                            item.levels = value.levels
//                            item.maintainanceCrew = value.maintainanceCrew
//                            item.maintainanceCrewHappiness = value.maintainanceCrewHappiness
//                            item.maxFuelHoldable = value.maxFuelHoldable
//                            item.pilotHappiness = value.pilotHappiness
//                            item.pilots = value.pilots
//                            item.pilotHappiness = value.pilotHappiness
//                            item.xp = value.xp
//                            
//                            try? modelContext.save()
//                        }
                    }
                    
                    let todaysDate: Date = Date()
                    let calendar = Calendar.current
                    guard let days = calendar.dateComponents([.day], from: calendar.startOfDay(for: moidifiableUserdata.wrappedValue.lastLogin), to: calendar.startOfDay(for: todaysDate) ).day else { return }
                    moidifiableUserdata.wrappedValue.daysPassedSinceStartOfFinancialWeek = days + moidifiableUserdata.wrappedValue.daysPassedSinceStartOfFinancialWeek
                    if moidifiableUserdata.wrappedValue.daysPassedSinceStartOfFinancialWeek >= 7 {
                        let numberOfDeductionsToMakeForSalary: Int
                        numberOfDeductionsToMakeForSalary = Int(moidifiableUserdata.wrappedValue.daysPassedSinceStartOfFinancialWeek / 7)
                        moidifiableUserdata.wrappedValue.daysPassedSinceStartOfFinancialWeek = moidifiableUserdata.wrappedValue.daysPassedSinceStartOfFinancialWeek % 7
                        moidifiableUserdata.wrappedValue.accountBalance = moidifiableUserdata.wrappedValue.accountBalance - Double(moidifiableUserdata.wrappedValue.cashToPayAsSalaryPerWeek * numberOfDeductionsToMakeForSalary)
                    }
                    moidifiableUserdata.wrappedValue.lastLogin = todaysDate
                    if days != 0 {
                        for _ in 1...days {
                            moidifiableUserdata.wrappedValue.flightAttendentHappiness -= Double.random(in: 0.01...0.03)
                            moidifiableUserdata.wrappedValue.pilotHappiness -= Double.random(in: 0.01...0.03)
                            moidifiableUserdata.wrappedValue.maintainanceCrewHappiness -= Double.random(in: 0.01...0.03)
                            
                        }
                    }
                    
                    // Recalculate fuel price for the time passed since last open
                    let hoursSinceLastFuelUpdate = Calendar.current.dateComponents([.hour], from: moidifiableUserdata.wrappedValue.lastFuelPriceCalculationDate, to: todaysDate).hour ?? 0
                    if hoursSinceLastFuelUpdate >= 2 {
                        let numberOfUpdates = hoursSinceLastFuelUpdate / 2
                        for _ in 0..<numberOfUpdates {
                            calculateNextFuelPrice(userData: moidifiableUserdata)
                        }
                    }
                    moidifiableUserdata.wrappedValue.lastFuelPriceCalculationDate = todaysDate
                    
                }
            /// Manages marking the plane as arrived or not at the first possible instant
                .onReceive(planeArrivalTimer) { _ in
                    let currentDate = Date()
                    for (index, plane) in moidifiableUserdata.wrappedValue.planes.enumerated() {
                        if plane.isAirborne && plane.estimatedLandingTime != nil {
                            if currentDate >= plane.estimatedLandingTime! {
                                moidifiableUserdata.wrappedValue.planes[index].markJetAsArrived(moidifiableUserdata)
                            }
                        } else if plane.inMaintainance {
                            if currentDate >= plane.endMaintainanceDate! {
                                moidifiableUserdata.wrappedValue.planes[index].markJetAsMaintainanceDone()
                            }
                        }
                    }
                    if moidifiableUserdata.wrappedValue.campaignRunning {
                        if moidifiableUserdata.wrappedValue.campaignEnd! <= currentDate {
                            resetCampaignUponEnd(userData: moidifiableUserdata)
                        }
                    }
                    
                    if moidifiableUserdata.wrappedValue.xpRequiredForNextXPLevel == 0 {
                        moidifiableUserdata.wrappedValue.levels += 1
                        moidifiableUserdata.wrappedValue.xpPoints += 1
                    }
                }
                .onReceive(fuelPriceTimer) { _ in
                    calculateNextFuelPrice(userData: moidifiableUserdata)
                    moidifiableUserdata.wrappedValue.lastFuelPriceCalculationDate = Date()
                }
                .onAppear {
                    let notificationsManager = NotificationsManager()
                    notificationsManager.requestPermission()
                    
                    /// COMMENT FOR FINAL REALEASE
                    /// debug stub to remove all notifications
//                    notificationsManager.removeAll()
                }
        }

    }
}

#Preview {
    ContentView(resetUserData: false, useTestData: .endGame)
}

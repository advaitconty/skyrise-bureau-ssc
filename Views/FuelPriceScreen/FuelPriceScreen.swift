//
//  FuelPriceScreen.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 25/11/25.
//

import SwiftUI
import Charts
import SwiftData

struct FuelPriceItem: Codable, Identifiable {
    var id: UUID = UUID()
    var fuelPrice: Double
    var hour: Int
    
}

struct FuelPriceView: View {
    @Query var actualUserData: [UserData]
    @Environment(\.modelContext) var modelContext
    var userData: Binding<UserData> {
        Binding {
            actualUserData.first ?? UserData(name: "Advait",
                                             airlineName: "IndiGo Atlantic",
                                             airlineIataCode: "6E",
                                             planes: [
                                                 FleetItem(aircraftID: "IL96-400M",
                                                           aircraftname: "Suka Blyat",
                                                           registration: "VT-SBL",
                                                           hoursFlown: 3,
                                                           assignedRoute: Route(originAirport: Airport(
                                                             name: "Adolfo Suárez Madrid-Barajas Airport",
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
                                                             name: "Adolfo Suárez Madrid-Barajas Airport",
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
                                                             name: "Adolfo Suárez Madrid-Barajas Airport",
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
                                                     name: "Adolfo Suárez Madrid-Barajas Airport",
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
            if let item = actualUserData.first {
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
    @State var lastFewFuelPriceItem: [FuelPriceItem] = []
    @State var amountOfFuelUserWantsToPurchase: Double = 1000.0
    @Environment(\.colorScheme) var colorScheme
    @State var exceedMax: Bool = false /// SET TO FALSE LATER
    @State var notEnoughBalance: Bool = false /// SET TO FALSE LATER
    var buttonDisabledStatus: Bool {
        return exceedMax || notEnoughBalance
    }
    
    func convertFuelPricesToChartItems(_ fuelPrices: [Double]) -> [FuelPriceItem] {
        return fuelPrices.enumerated().map { index, price in
            FuelPriceItem(fuelPrice: price, hour: index * 2)
        }
    }
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                HStack {
                    Text("Purchase Fuel")
                        .font(.largeTitle)
                        .fontWidth(.expanded)
                    Spacer()
                    VStack {
                        (Text("CURRENT BALANCE:\n")
                            .fontWidth(.condensed)
                            .font(.caption)
                        +
                         Text("$\(userData.wrappedValue.accountBalance.withCommas)")
                            .font(.title3)
                            .fontWidth(.expanded))
                            .multilineTextAlignment(.trailing)
                            .contentTransition(.numericText(countsDown: true))
                    }
                }
                HStack {
                    /// SwiftUI chart
                    /// Things that may work:
                    /// volatility, max high, max low
                    chartView()
                    .frame(width: reader.size.width / 2)
                    VStack {
                        HStack {
                            Text("CURRENT PRICE:")
                                .font(.callout)
                                .fontWidth(.condensed)
                            Spacer()
                            (Text("$\(Int(userData.wrappedValue.currentFuelPrice))")
                                .font(.title)
                                .fontWidth(.expanded)
                            +
                            Text("\nfor 1000 kilos")
                                .font(.caption)
                                .fontWidth(.expanded))
                            .multilineTextAlignment(.trailing)
                            .contentTransition(.numericText(countsDown: true))
                        }
                        
                        textFieldItem()
                        
                        extraInformation(reader.size.width)
                            .padding([.bottom])
                        
                        errorInfoScreen(reader.size.width)
                        
                        Button {
                            withAnimation {
                                userData.wrappedValue.currentlyHoldingFuel = userData.wrappedValue.currentlyHoldingFuel + Int(amountOfFuelUserWantsToPurchase)
                                userData.wrappedValue.accountBalance = userData.wrappedValue.accountBalance - userData.wrappedValue.currentFuelPrice/1000 * amountOfFuelUserWantsToPurchase
                            }
                            /// CLOSE WINDOW AFTER THIS
                        } label: {
                            Spacer()
                            Text("Execute fuel trade")
                                .fontWidth(.condensed)
                            Spacer()
                        }
                        .disabled(buttonDisabledStatus)
                        
                        
                        /// Current fuel capacity
                        VStack {
                            ProgressView(value: Double(userData.wrappedValue.currentlyHoldingFuel)/Double(userData.wrappedValue.maxFuelHoldable)) {
                                HStack {
                                    Text("CURRENT \nFUEL HOLD:\n")
                                        .font(.caption)
                                        .fontWidth(.condensed)
                                    Spacer()
                                    Text("\(userData.wrappedValue.currentlyHoldingFuel.withCommas)kg/\(userData.wrappedValue.maxFuelHoldable.withCommas)kg")
                                        .fontWidth(.expanded)
                                        .multilineTextAlignment(.trailing)
                                        .lineLimit(2, reservesSpace: true)
                                        .contentTransition(.numericText(countsDown: true))
                                }
                            }
                        }
                    }
                    .padding()
                    .frame(width: reader.size.width / 2)
                }
            }
            .onAppear {
                print(reader.size)
            }
        }
        .padding()
        .onAppear {
            let item = userData.wrappedValue.lastFewFuelPricesForGraph
            lastFewFuelPriceItem = convertFuelPricesToChartItems(item)
        }
        .frame(width: 800, height: 550)
    }
}

//var testUserDataModifiable = testUserData

struct FuelPriceView_Previews: PreviewProvider {
    static var previews: some View {
        FuelPriceView()
    }
}

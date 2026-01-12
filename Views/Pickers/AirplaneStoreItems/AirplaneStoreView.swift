import SwiftUI
import AppKit
import CompactSlider
import SwiftData

struct AirplaneStoreView: View {
    @Query var swiftDataUserData: [UserData]
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismissWindow) var dismissWindow
    var userData: Binding<UserData> {
        Binding {
            swiftDataUserData.first ?? UserData(name: "Advait",
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
    @State var searchTerm: String = ""
    @State var selectedType: String? = nil
    @Environment(\.colorScheme) var colorScheme
    let cornerRadius = 10.0
    @State var showPlaneStats: Aircraft? = nil
    @State var showPlane: Bool = false
    @State var preferedSeatingConfig: SeatingConfig = SeatingConfig(economy: 0, premiumEconomy: 0, business: 0, first: 0)
    @State var showContextScreen: Bool = false
    @State var showNotAllSeatsFilled: Bool = false
    @State var showAllSeatsFileld: Bool = false
    @State var registration: String = "SB-"
    @State var aircraftName: String = "Horizon Jet"
    @State var airportToDeliverPlaneTo: Airport = Airport(
        name: "Los Angeles International Airport",
        city: "Los Angeles",
        country: "United States",
        iata: "LAX",
        icao: "KLAX",
        region: .northAmerica,
        latitude: 33.9416,
        longitude: -118.4085,
        runwayLength: 3939,
        elevation: 38,
        demand: AirportDemand(passengerDemand: 10.0, cargoDemand: 9.0, businessTravelRatio: 0.72, tourismBoost: 0.88),
        facilities: AirportFacilities(terminalCapacity: 240000, cargoCapacity: 4500, gatesAvailable: 130, slotEfficiency: 0.92)
    )
    
    var filteredPlanes: [Aircraft] {
        AircraftDatabase.shared.allAircraft.filter { plane in
            let matchesSearch = searchTerm.isEmpty || plane.name.localizedCaseInsensitiveContains(searchTerm) || plane.manufacturer.rawValue.localizedCaseInsensitiveContains(searchTerm)
            
            let matchesType = selectedType == nil
            
            return matchesSearch && matchesType
        }
    }
        
    var body: some View {
        if showPlane == false {
            shopView(userData.wrappedValue)
                .transition(.move(edge: .leading))
        } else {
            if let plane = showPlaneStats {
                planeStatsView(plane: plane)
                    .transition(.move(edge: .trailing))
            }
        }
    }
}

#Preview {
    AirplaneStoreView()
}

//
//  Tooling.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 19/2/26.
//

import FoundationModels

struct GetAirlineOverview: Tool {
    let name: String = "get_airline_overview"
    let description: String = "Returns a summary of the airline's current finances"
    
    private let userData: UserData
    
    init(userData: UserData) {
        self.userData = userData
    }
    
    @Generable
    struct Arguments {
        
    }
    
    func call(arguments: Arguments) async throws -> String {
        let output: String = """
        Airline: \(userData.airlineName) (\(userData.airlineIataCode))
        Account Balance: $\(userData.accountBalance)
        Reputation: \(userData.airlineReputation)
        Reliability: \(userData.reliabilityIndex)
        Fleet size: \(userData.planes.count) aircraft
        Hubs: \(userData.hubsAcquired.map(\.iata).joined(separator: ", "))
        """
        
        return output
    }
}

struct GetFleetStatus: Tool {
    let name: String = "get_fleet_status"
    let description: String = "Returns the status of every single aircraft in the fleet, including their maintainance status, and if they are airborne"
    
    private let userData: UserData
    
    init(userData: UserData) {
        self.userData = userData
    }
    
    @Generable
    struct Arguments {
        
    }
    
    func call(arguments: Arguments) async throws -> String {
        let summary: String = userData.planes.map { plane in
            """
            \(plane.registration) '\(plane.aircraftname)', which is an \(plane.aircraftID)
            Status: \(plane.inMaintainance ? "In maintainance" : (plane.isAirborne ? "Is flying" : "On ground at \(plane.currentAirportLocation!.iata) (\(plane.currentAirportLocation!.icao))"))
            Assigned Route: \(plane.assignedRoute == nil ? "No route assigned" : "From \(plane.assignedRoute!.originAirport.iata) (\(plane.assignedRoute!.originAirport.icao)) to \(plane.assignedRoute!.arrivalAirport.iata) (\(plane.assignedRoute!.arrivalAirport.icao)")
            Maintainance status: Currently at \((plane.condition * 100).withCommas)% condition
            """
        }.joined(separator: "-----")
        if summary.isEmpty {
            return "No aircraft in fleet"
        } else {
            return summary
        }
    }
}

struct GetStaffStatus: Tool {
    let name: String = "get_staff_status"
    let description: String = "Gets the current staff counts, happiness levels, and weekly salary costs"
    
    private let userData: UserData
    
    init(userData: UserData) {
        self.userData = userData
    }
    
    @Generable
    struct Arguments {
        
    }
    
    func call(arguments: Arguments) async throws -> String {
        let output = """
        Pilots: \(userData.pilots) (happiness: \(userData.pilotHappiness))
        Flight Attendants: \(userData.flightAttendents) (happiness: \(userData.flightAttendentHappiness))
        Maintenance Crew: \(userData.maintainanceCrew) (happiness: \(userData.maintainanceCrewHappiness))
        Weekly salary cost: $\(userData.cashToPayAsSalaryPerWeek)
        """
        return output
    }
}

struct GetFuelStatus: Tool {
    let name: String = "get_fuel_status"
    let description: String  = "Gets the current fuel price, fuel held by the player, the amount of fuel they have bought at the last price, and the last 20 fuel prices over the last 10 mins"
    
    private let userData: UserData
    
    init(userData: UserData) {
        self.userData = userData
    }
    
    @Generable
    struct Arguments {
        
    }
    
    func call(arguments: Arguments) async throws -> some PromptRepresentable {
        let formattedLast20FuelPrices: String = userData.lastFewFuelPricesForGraph.map { price in
            let priceString = "$" + String(format: "%.2f", price)
            return "\(priceString)"
        }.joined(separator: ",")
        let output = """
        Current fuel price: $\(userData.currentFuelPrice)/1000kgs
        Fuel held: \(userData.currentlyHoldingFuel)kgs / \(userData.maxFuelHoldable)kgs
        Last 20 fuel prices (latest price at the end): \(formattedLast20FuelPrices)
        """
        return output
    }
}

struct GetFinancialSummaries: Tool {
    let name: String = "get_financial_summary"
    let description: String = "Gets a breakdown of this week's income and expenditure"
    
    private let userData: UserData
    
    init(userData: UserData) {
        self.userData = userData
    }
    
    @Generable
    struct Arguments {
        
    }
    
    func call(arguments: Arguments) async throws -> some PromptRepresentable {
        let output = """
                Revenue from departures: \(userData.amountOfMoneyMadeFromDeparturesInTheLastWeek.map { price in
                let priceString = "$" + String(format: "%.2f", price)
                return "\(priceString)"
                }.joined(separator: ","))
                Spent on fuel: $\(userData.amountSpentOnFuelInTheLastWeek.map { price in
                let priceString = "$" + String(format: "%.2f", price)
                return "\(priceString)"
                }.joined(separator: ","))
                Spent on planes: $\(userData.amountSpentOnPlanesInTheLastWeek.map { price in
                let priceString = "$" + String(format: "%.2f", price)
                return "\(priceString)"
                }.joined(separator: ","))
                Spent on hubs: $\(userData.amountSpentOnHubsAccquisitionInTheLastWeek.map { price in
                let priceString = "$" + String(format: "%.2f", price)
                return "\(priceString)"
                }.joined(separator: ","))
                Weekly salary obligation: $\(userData.cashToPayAsSalaryPerWeek)
                """
        return output
    }
}

struct LookupAircraft: Tool {
    let name = "lookup_aircraft"
    let description = "Looks up an aircraft type from the database by its ID, returning its specifications including range, fuel burn rate, and seating capacity."
    
    @Generable
    struct Arguments {
        @Guide(description: "The aircraft ID to look up, e.g. 'B737-800NG', 'A320', 'CRJ900'")
        var aircraftID: String
    }
    
    func call(arguments: Arguments) -> String {
        guard let aircraft = AircraftDatabase.shared.allAircraft.first(where: { $0.id == arguments.aircraftID }) else {
            return "No aircraft found with ID '\(arguments.aircraftID)'."
        }
        return """
        Aircraft: \(aircraft.name) (\(aircraft.id))
        Range: \(aircraft.maxRange) km
        Fuel burn rate: \(aircraft.fuelBurnRate) units/km
        Seating Capacity: \(aircraft.maxSeats)
        """
    }
}

struct LookupAirport: Tool {
    let name = "lookup_airport"
    let description = "Looks up an airport by its IATA or ICAO code, returning its location, demand, and facilities."
    
    @Generable
    struct Arguments {
        @Guide(description: "The IATA or ICAO code of the airport, e.g. 'LHR', 'EGLL', 'BLR'")
        var code: String
    }
    
    func call(arguments: Arguments) -> String {
        let db = AirportDatabase.shared
        guard let airport = db.allAirports.first(where: {
            $0.iata.uppercased() == arguments.code.uppercased() ||
            $0.icao.uppercased() == arguments.code.uppercased()
        }) else {
            return "No airport found with code '\(arguments.code)'."
        }
        return """
        Airport: \(airport.name) (\(airport.iata) / \(airport.icao))
        City: \(airport.city), \(airport.country)
        Region: \(airport.region)
        Runway length: \(airport.runwayLength)m
        Elevation: \(airport.elevation)m
        """
    }
}

struct CalculateRouteDistance: Tool {
    let name = "calculate_route_distance"
    let description = "Calculates the distance in kilometres between two airports by their IATA or ICAO codes."
    
    @Generable
    struct Arguments {
        @Guide(description: "IATA or ICAO code of the origin airport")
        var originCode: String
        @Guide(description: "IATA or ICAO code of the destination airport")
        var destinationCode: String
    }
    
    func call(arguments: Arguments) -> String {
        let db = AirportDatabase.shared
        guard let origin = db.allAirports.first(where: {
            $0.iata.uppercased() == arguments.originCode.uppercased() ||
            $0.icao.uppercased() == arguments.originCode.uppercased()
        }) else {
            return "No airport found with code '\(arguments.originCode)'."
        }
        guard let destination = db.allAirports.first(where: {
            $0.iata.uppercased() == arguments.destinationCode.uppercased() ||
            $0.icao.uppercased() == arguments.destinationCode.uppercased()
        }) else {
            return "No airport found with code '\(arguments.destinationCode)'."
        }
        let distance = db.calculateDistance(from: origin, to: destination)
        return "Distance from \(origin.iata) to \(destination.iata): \(distance) km"
    }
}

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

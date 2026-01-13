//
//  SettingsView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 3/12/25.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @State var showNotificationsLog: Bool = false
    @ObservedObject var notificationsManager = NotificationsManager()
    @State var notifications: [NotificationItem] = []
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
            if let item = userData.first {
                item.preferredAirlineCodeType = value.preferredAirlineCodeType
                item.allowedNotificationTypes = value.allowedNotificationTypes
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
    var body: some View {
        VStack {
            HStack {
                Text("Settings")
                    .font(.largeTitle)
                    .fontWidth(.expanded)
                Spacer()
            }
            /// Code selection
            /// For selecting ICAO/IATA codes on the map
            HStack {
                Text("Preferred Code for Airports")
                    .fontWidth(.expanded)
                Spacer()
                Button {
                    withAnimation {
                        moidifiableUserdata.wrappedValue.preferredAirlineCodeType = "iata"
                    }
                } label: {
                    Text("IATA (e.g. AUH/LAX)")
                        .fontWidth(.condensed)
                }
                .adaptiveProminentButtonStyle()
                .tint(moidifiableUserdata.wrappedValue.preferedAirlineCodeType == .iata ? Color.accentColor : .gray)
                Button {
                    withAnimation {
                        moidifiableUserdata.wrappedValue.preferredAirlineCodeType = "icao"
                    }
                } label: {
                    Text("ICAO (e.g. OMAA/KLAX)")
                        .fontWidth(.condensed)
                }
                .adaptiveProminentButtonStyle()
                .tint(moidifiableUserdata.wrappedValue.preferedAirlineCodeType == .icao ? Color.accentColor : .gray)
            }
            /// Notification preferences manager
            HStack {
                Text("Notifications To Send")
                    .fontWidth(.expanded)
                Spacer()
                Button {
                    if !moidifiableUserdata.wrappedValue.allowedNotificationTypes.contains(.arrival) {
                        withAnimation {
                            moidifiableUserdata.wrappedValue.allowedNotificationTypes.append(.arrival)
                        }
                    } else {
                        withAnimation {
                            moidifiableUserdata.wrappedValue.allowedNotificationTypes.removeAll(where: { $0 == .arrival })
                        }
                    }
                } label: {
                    Text("Jet Arrival")
                        .fontWidth(.condensed)
                }
                .adaptiveProminentButtonStyle()
                .tint(moidifiableUserdata.wrappedValue.allowedNotificationTypes.contains(.arrival) ? Color.accentColor : .gray)
                
                Button {
                    if !moidifiableUserdata.wrappedValue.allowedNotificationTypes.contains(.maintainanceEnd) {
                        withAnimation {
                            moidifiableUserdata.wrappedValue.allowedNotificationTypes.append(.maintainanceEnd)
                        }
                    } else {
                        withAnimation {
                            moidifiableUserdata.wrappedValue.allowedNotificationTypes.removeAll(where: { $0 == .maintainanceEnd })
                        }
                    }
                } label: {
                    Text("End of Maintainance")
                        .fontWidth(.condensed)
                }
                .adaptiveProminentButtonStyle()
                .tint(moidifiableUserdata.wrappedValue.allowedNotificationTypes.contains(.maintainanceEnd) ? Color.accentColor : .gray)
                
                Button {
                    if !moidifiableUserdata.wrappedValue.allowedNotificationTypes.contains(.campaignEnd) {
                        withAnimation {
                            moidifiableUserdata.wrappedValue.allowedNotificationTypes.append(.campaignEnd)
                        }
                    } else {
                        withAnimation {
                            moidifiableUserdata.wrappedValue.allowedNotificationTypes.removeAll(where: { $0 == .campaignEnd })
                        }
                    }
                } label: {
                    Text("End of Campaign")
                        .fontWidth(.condensed)
                }
                .adaptiveProminentButtonStyle()
                .tint(moidifiableUserdata.wrappedValue.allowedNotificationTypes.contains(.campaignEnd) ? Color.accentColor : .gray)
            }
            
            /// Notifications stats for nerds
            Group {
                Button {
                    Task {
                        await notificationsManager.fetchPendingNotifications()
                        withAnimation {
                            showNotificationsLog.toggle()
                        }
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("Notification stats for nerds")
                            .fontWidth(.expanded)
                        Spacer()
                    }
                }
                .adaptiveProminentButtonStyle()
                .tint(showNotificationsLog ? Color.accentColor : .gray)
                
                if showNotificationsLog {
                    ScrollView {
                        HStack {
                            Text("All scheduled notifications: ".uppercased())
                                .fontWidth(.expanded)
                            Spacer()
                        }
                        ForEach(notificationsManager.notifications, id: \.id) { notification in
                            Divider()
                            VStack {
                                HStack {
                                Text("\(notification.notificationTitle) - ")
                                    .fontWidth(.expanded)
                                +
                                Text("\(notification.notificationBody)")
                                    .fontWidth(.condensed)
                                Spacer()
                                }
                                HStack {
                                    Text("Scheduled for \(notification.formattedSendTime)")
                                        .fontWidth(.condensed)
                                    Spacer()
                                }
                            }
                        }
                    }
                    .frame(minHeight: 100)
                }
            }
        }
        .padding()
    }
}

#Preview {
    SettingsView()
}

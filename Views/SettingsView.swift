//
//  SettingsView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 8/12/25.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.dismissWindow) var dismissWindow
    @Environment(\.dismiss) var dismiss
    @Query var userData: [UserData]
    @Environment(\.modelContext) var modelContext
    var modifiableUserData: Binding<UserData> {
        Binding {
            if let userData = userData.first {
                if userData.planes.isEmpty {
                    #if os(macOS)
                        dismissWindow()
                    #elseif os(iOS)
                        dismiss()
                    #endif
                }
                return userData
            } else {
                modelContext.insert(newUserData)
                #if os(macOS)
                    dismissWindow()
                #elseif os(iOS)
                    dismiss()
                #endif
                return newUserData
            }
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
    @Namespace var notifNamespace
    @Namespace var airportCodeNamespace
    var body: some View {
        VStack {
            
            HStack {
                Image(systemName: "gearshape.2")
                    .font(.largeTitle)
                Text("Skyrise Bureau Settings")
                    .font(.largeTitle)
                    .fontWidth(.expanded)
                Spacer()
                if #available(iOS 26.0, *) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                    }
                    .tint(.gray)
                    .buttonStyle(.glass)
                } else {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                    }
                    .tint(.gray)
                    .buttonStyle(.plain)
                }
            }
            Spacer()
            // MARK: Notification settings stuff
            VStack {
                HStack {
                    Text("Preferred Airport Code Type:")
                        .font(.title)
                        .fontWidth(.expanded)
                    Spacer()
                }
                HStack {
                    Spacer()
                    if #available(iOS 26.0, *) {
                        if modifiableUserData.wrappedValue.preferedAirlineCodeType == .iata {
                            Button {
                                withAnimation {
                                    modifiableUserData.wrappedValue.preferredAirlineCodeType = "iata"
                                }
                            } label: {
                                Text("IATA (e.g. SIN, DXB, AUH, LHR, LAX)")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glassProminent)
                            .matchedGeometryEffect(id: "airportCode:iata", in: airportCodeNamespace)
                            
                            Button {
                                withAnimation {
                                    modifiableUserData.wrappedValue.preferredAirlineCodeType = "icao"
                                }
                            } label: {
                                Text("ICAO (e.g. WSSS, OMDB, OMAA, EGLL, KLAX)")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glass)
                            .matchedGeometryEffect(id: "airportCode:icao", in: airportCodeNamespace)
                        } else {
                            Button {
                                withAnimation {
                                    modifiableUserData.wrappedValue.preferredAirlineCodeType = "iata"
                                }
                            } label: {
                                Text("IATA (e.g. SIN, DXB, AUH, LHR, LAX)")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glass)
                            .matchedGeometryEffect(id: "airportCode:iata", in: airportCodeNamespace)
                            
                            
                            Button {
                                withAnimation {
                                    modifiableUserData.wrappedValue.preferredAirlineCodeType = "icao"
                                }
                            } label: {
                                Text("ICAO (e.g. WSSS, OMDB, OMAA, EGLL, KLAX)")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glassProminent)
                            .matchedGeometryEffect(id: "airportCode:icao", in: airportCodeNamespace)
                        }
                    } else {
                        if modifiableUserData.wrappedValue.preferedAirlineCodeType == .iata {
                            Button {
                                withAnimation {
                                    modifiableUserData.wrappedValue.preferredAirlineCodeType = "iata"
                                }
                            } label: {
                                Text("IATA (e.g. SIN, DXB, AUH, LHR, LAX)")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.borderedProminent)
                            .matchedGeometryEffect(id: "airportCode:iata", in: airportCodeNamespace)
                            
                            Button {
                                withAnimation {
                                    modifiableUserData.wrappedValue.preferredAirlineCodeType = "icao"
                                }
                            } label: {
                                Text("ICAO (e.g. WSSS, OMDB, OMAA, EGLL, KLAX)")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.bordered)
                            .matchedGeometryEffect(id: "airportCode:icao", in: airportCodeNamespace)
                        } else {
                            Button {
                                withAnimation {
                                    modifiableUserData.wrappedValue.preferredAirlineCodeType = "iata"
                                }
                            } label: {
                                Text("IATA (e.g. SIN, DXB, AUH, LHR, LAX)")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.bordered)
                            .matchedGeometryEffect(id: "airportCode:iata", in: airportCodeNamespace)
                            
                            
                            Button {
                                withAnimation {
                                    modifiableUserData.wrappedValue.preferredAirlineCodeType = "icao"
                                }
                            } label: {
                                Text("ICAO (e.g. WSSS, OMDB, OMAA, EGLL, KLAX)")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.borderedProminent)
                            .matchedGeometryEffect(id: "airportCode:icao", in: airportCodeNamespace)
                        }
                        
                    }
                }
            }
            
            VStack {
                HStack {
                    Text("Preferred Notification Types:")
                        .font(.title)
                        .fontWidth(.expanded)
                    Spacer()
                }
                HStack {
                    Spacer()
                    if #available(iOS 26.0, *) {
                        if modifiableUserData.wrappedValue.allowedNotificationTypes.contains(.arrival) {
                            Button {
                                withAnimation {
                                    modifiableUserData.wrappedValue.allowedNotificationTypes.removeAll(where: { $0 == .arrival })
                                }
                            } label: {
                                Text("Aircraft Arrival")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glassProminent)
                            .matchedGeometryEffect(id: "notif:arrival", in: notifNamespace)
                        } else {
                            Button {
                                withAnimation {
                                    modifiableUserData.wrappedValue.allowedNotificationTypes.append(.arrival)
                                }
                            } label: {
                                Text("Aircraft Arrival")
                            }
                            .buttonStyle(.glass)
                            .matchedGeometryEffect(id: "notif:arrival", in: notifNamespace)
                        }
                        
                        if modifiableUserData.wrappedValue.allowedNotificationTypes.contains(.maintainanceEnd) {
                            Button {
                                withAnimation {
                                    modifiableUserData.wrappedValue.allowedNotificationTypes.removeAll(where: { $0 == .maintainanceEnd })
                                }
                            } label: {
                                Text("Aircraft Maintainance Completion")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glassProminent)
                            .matchedGeometryEffect(id: "notif:maintainance", in: notifNamespace)
                        } else {
                            Button {
                                withAnimation {
                                    modifiableUserData.wrappedValue.allowedNotificationTypes.append(.maintainanceEnd)
                                }
                            } label: {
                                Text("Aircraft Maintainance Completion")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glass)
                            .matchedGeometryEffect(id: "notif:maintainance", in: notifNamespace)
                        }
                        
                        if modifiableUserData.wrappedValue.allowedNotificationTypes.contains(.campaignEnd) {
                            Button {
                                withAnimation {
                                    modifiableUserData.wrappedValue.allowedNotificationTypes.removeAll(where: { $0 == .campaignEnd })
                                }
                            } label: {
                                Text("Marketing Campaign End")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glassProminent)
                            .matchedGeometryEffect(id: "notif:campaign", in: notifNamespace)
                        } else {
                            Button {
                                withAnimation {
                                    modifiableUserData.wrappedValue.allowedNotificationTypes.append(.campaignEnd)
                                }
                            } label: {
                                Text("Marketing Campaign End")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glass)
                            .matchedGeometryEffect(id: "notif:campaign", in: notifNamespace)
                        }
                    }
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SettingsView()
}

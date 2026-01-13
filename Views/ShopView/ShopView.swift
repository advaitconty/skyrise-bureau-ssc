//
//  ShopView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 4/12/25.
//

import SwiftUI
import SwiftData

struct ShopView: View {
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
    @Environment(\.colorScheme) var colorScheme
    let cornerRadius: CGFloat = 10.0
    @State var preferedSeatingConfig = SeatingConfig(economy: 0, premiumEconomy: 0, business: 0, first: 0)
    @State var searchTerm: String = ""
    @State var selectedPlane: Aircraft? = nil
    @State var showAllSeatsFilled: Bool = false
    @State var showNotAllSeatsFullWarning: Bool = false
    @State var aircraftName: String = "Horizon Jet"
    @State var registration: String = "SB-"
    
    var filteredPlanes: [Aircraft] {
        AircraftDatabase.shared.allAircraft.filter { plane in
            let matchesSearch = searchTerm.isEmpty || plane.name.localizedCaseInsensitiveContains(searchTerm) || plane.manufacturer.rawValue.localizedCaseInsensitiveContains(searchTerm)
            
            return matchesSearch
        }
    }
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                HStack {
                    Text("Jet Set Emporium\n")
                        .font(.largeTitle)
                        .fontWidth(.expanded)
                        +
                    Text("Current account balance: $\(modifiableUserData.wrappedValue.accountBalance.withCommas)")
                        .fontWidth(.condensed)
                    Spacer()
                        .onAppear {
                            /// DEBUG STUB
                            /// Remove upon final release
                            selectedPlane = filteredPlanes[52]
                        }
                    if #available(iOS 26.0, *) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.largeTitle)
                                .symbolRenderingMode(.hierarchical)
                        }
                        .tint(.gray)
                        .hoverEffect()
                        .buttonStyle(.glass)
                    } else {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.largeTitle)
                                .symbolRenderingMode(.hierarchical)
                        }
                        .tint(.gray)
                        .hoverEffect()
                    }
                }
                .padding([.top, .leading, .trailing])
                NavigationSplitView {
                    VStack {
                        List(filteredPlanes, selection: $selectedPlane) { plane in
                            NavigationLink(value: plane) {
                                buttonLabel(plane: plane)
                                .listRowInsets(EdgeInsets())
                            }
                        }
                    }
                    if #available(iOS 26.0, *) {
                        HStack {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                TextField("Search for planes", text: $searchTerm)
                                    .fontWidth(.condensed)
                                    .textFieldStyle(.automatic)
                            }.padding()
                        }
                        .glassEffect(.regular, in: Capsule())
                        .padding()
                    } else {
                        HStack {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                TextField("Search for planes", text: $searchTerm)
                                    .fontWidth(.condensed)
                                    .textFieldStyle(.automatic)
                            }.padding()
                        }
                        .padding()
                    }
                } detail: {
                    if selectedPlane != nil {
                        planeConfiguratorView(selectedPlane!)
                            .padding()
                    } else {
                        Text("Select a plane to get more information on it.")
                            .fontWidth(.expanded)
                    }
                }
                .navigationSplitViewStyle(.balanced)
                .onChange(of: selectedPlane) {
                    if selectedPlane != nil {
                        preferedSeatingConfig = selectedPlane!.defaultSeating
                    }
                }
            }
        }
    }
}

#Preview {
    ShopView()
}

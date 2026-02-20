//
//  MapManager.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/12/25.
//

import MapKit
import SwiftUI
import Combine

class Clock: ObservableObject {
    @Published var now = Date()
    private var timer = Timer()
    
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.now = Date()
        }
    }
}

struct MapManagerView: View {
    @Environment(\.openWindow) var openWindow
    @State var airportSelector: Bool = false
    @State var openFuelWindow: Bool = false
    @State var openAIView: Bool = false
    @Namespace var mapScope
    @Namespace var namespace
    @State var mapType: MapStyle = .standard(elevation: .realistic, pointsOfInterest: .all)
    @State var temporarilySelectedAirportToGetMoreInformationOn: Airport? = nil
    @State var selectedPlane: FleetItem? = nil
    @Environment(\.colorScheme) var colorScheme
    @Binding var userData: UserData
    @State var sidebarWidth: Float = 350
    @State var selectedJet: Int? = nil
    @State var showSidebar: Bool = true
    @State var showAIView: Bool = false
    @State var isAIAvailable: Bool = false
//    @StateObject var clock = Clock()
    @State var openSettings: Bool = false
    @State var openUserUpgradeView: Bool = false
    @State var takeoffItems: DepartureDoneSuccessfullyItemsToShow? = nil
    @State var showTakeoffPopup: Bool = false
    @State var openShopView: Bool = false
    @State var mapCameraPosition: OfflineMapPosition = .world
    @State var countSincePopupAppeared: Int = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            GeometryReader { reader in
                // map item
                ZStack(alignment: .bottomLeading) {
                    OfflineMap(position: $mapCameraPosition) {
                        OfflineMapContentGroup(
                            annotations: AirportDatabase.shared.allAirports.map { airport in
                                airport.asOfflineAnnotation(hubIATAs: userData.hubsAcquired.map(\.iata))
                            } + userData.planes.map { plane in
                                OfflineAnnotation(
                                    id: plane.id.uuidString,
                                    coordinate: plane.isAirborne
                                        ? plane.planeLocationInFlight
                                        : CLLocationCoordinate2D(
                                            latitude: plane.currentAirportLocation?.latitude ?? 0,
                                            longitude: plane.currentAirportLocation?.longitude ?? 0
                                        ),
                                    kind: .aircraft(registration: plane.registration, isAirborne: plane.isAirborne)
                                )
                            },
                            routes: userData.planes.compactMap { plane -> OfflineRoute? in
                                guard let route = plane.assignedRoute else { return nil }
                                return route.asOfflineRoute(isActive: plane.isAirborne)
                            }
                        )
                    }
                }
                
                HStack(spacing: 0) {
                    VStack {
                        HStack(spacing: 0) {
                            if selectedJet == nil {
                                VStack {
                                    HStack {
                                        if #available(iOS 26.0, *) {
                                            (Text(userData.airlineName)
                                                .fontWidth(.expanded)
                                                .font(.title)
                                             +
                                             Text("\nmanaged by \(userData.name)")
                                                .fontWidth(.condensed))
                                            .containerCornerOffset(.leading, sizeToFit: true)
                                        } else {
                                            (Text(userData.airlineName)
                                                .fontWidth(.expanded)
                                                .font(.title)
                                             +
                                             Text("\nmanaged by \(userData.name)")
                                                .fontWidth(.condensed))
                                        }
                                        Spacer()
                                    }
                                    
                                    ScrollView {
                                        if amountOfNotDepartedPlanes(userData) > 0 {
                                            Button {
                                                var jetsDepartedSuccessfully: [DepartureDoneSuccessfullyItems] = []
                                                for (index, plane) in userData.planes.enumerated() {
                                                    if !plane.isAirborne && !plane.inMaintainance {
                                                        var attempt = userData.planes[index].departJet($userData)
                                                        if attempt.departedSuccessfully {
                                                            attempt.planeInfo = userData.planes[index]
                                                            jetsDepartedSuccessfully.append(attempt)
                                                        }
                                                    }
                                                }
                                                var planesTakenOff: [FleetItem] = []
                                                var economyPassengersServed: Int = 0
                                                var premiumEconomyPassengersServed: Int = 0
                                                var businessPassengersServed: Int = 0
                                                var firstPassengersServed: Int = 0
                                                
                                                var maxEconomyPassengersServed: Int = 0
                                                var maxPremiumEconomyPassengersServed: Int = 0
                                                var maxBusinessPassengersServed: Int = 0
                                                var maxFirstPassengersServed: Int = 0
                                                
                                                var totalMoneyMade: Double = 0
                                                
                                                for jetDepartedSuccessfully in jetsDepartedSuccessfully {
                                                    planesTakenOff.append(jetDepartedSuccessfully.planeInfo ?? FleetItem(aircraftID: "somethong", aircraftname: "goasngo", registration: "gaogns", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 4, premiumEconomy: 41, business: 414, first: 41), kilometersTravelledSinceLastMaintainence: 4))
                                                    economyPassengersServed += jetDepartedSuccessfully.seatsUsedInPlane!.economy
                                                    premiumEconomyPassengersServed += jetDepartedSuccessfully.seatsUsedInPlane!.premiumEconomy
                                                    businessPassengersServed += jetDepartedSuccessfully.seatsUsedInPlane!.business
                                                    firstPassengersServed += jetDepartedSuccessfully.seatsUsedInPlane!.first
                                                    maxEconomyPassengersServed += jetDepartedSuccessfully.seatingConfigOfJet!.economy
                                                    maxPremiumEconomyPassengersServed += jetDepartedSuccessfully.seatingConfigOfJet!.premiumEconomy
                                                    maxBusinessPassengersServed += jetDepartedSuccessfully.seatingConfigOfJet!.business
                                                    maxFirstPassengersServed += jetDepartedSuccessfully.seatingConfigOfJet!.first
                                                    totalMoneyMade += jetDepartedSuccessfully.moneyMade!
                      
                                                }
                                                
                                                takeoffItems = DepartureDoneSuccessfullyItemsToShow(planesTakenOff: planesTakenOff, economyPassenegersServed: economyPassengersServed, premiumEconomyPassenegersServed: premiumEconomyPassengersServed, businessPassengersServed: businessPassengersServed, firstClassPassengersServed: firstPassengersServed, maxEconomyPassenegersServed: maxEconomyPassengersServed, maxPremiumEconomyPassenegersServed: maxPremiumEconomyPassengersServed, maxBusinessPassengersServed: maxBusinessPassengersServed, maxFirstClassPassengersServed: maxFirstPassengersServed, moneyMade: totalMoneyMade)
                                                withAnimation {
                                                    showTakeoffPopup = true
                                                }
                                            } label: {
                                                HStack {
                                                    Spacer()
                                                    Text("Depart all (\(amountOfNotDepartedPlanes(userData)) flight\(amountOfNotDepartedPlanes(userData) == 1 ? "" : "s") to depart)")
                                                        .fontWidth(.condensed)
                                                    Spacer()
                                                }
                                            }
                                            .adaptiveProminentButtonStyle()
                                            .hoverEffect()
                                        }
                                        
                                        ForEach(userData.planes, id: \.id) { plane in
                                            Button {
                                                withAnimation {
                                                    selectedJet = userData.planes.firstIndex(where: { $0.id == plane.id })!
                                                }
                                            } label: {
                                                planeItemView(plane)
                                            }
                                            .buttonStyle(.plain)
                                            .hoverEffect()
                                        }
                                    }
                                    
                                    Spacer()
                                    /// For the extras
                                    VStack {
                                        ProgressView(value: userData.progressToNextXPLevel) {
                                            HStack {
                                                Text("\(userData.xp) XP - Level \(userData.currentLevel)")
                                                    .fontWidth(.condensed)
                                                    .contentTransition(.numericText(countsDown: false))
                                                Spacer()
                                                Text("\(userData.xpRequiredForNextXPLevel) XP to next level")
                                                    .fontWidth(.condensed)
                                                    .contentTransition(.numericText(countsDown: true))
                                            }
                                        }
                                        
                                        ProgressView(value: Float(userData.currentlyHoldingFuel/userData.maxFuelHoldable)) {
                                            HStack {
                                                Text("Fuel Capacity")
                                                    .fontWidth(.condensed)
                                                    .contentTransition(.numericText(countsDown: false))
                                                Spacer()
                                                Text("\(userData.currentlyHoldingFuel.withCommas)kgs/\(userData.maxFuelHoldable.withCommas)kgs")
                                                    .fontWidth(.condensed)
                                                    .contentTransition(.numericText(countsDown: true))
                                            }
                                        }
                                        
                                        ProgressView(value: userData.airlineReputation) {
                                            HStack {
                                                Text("Reputation")
                                                    .fontWidth(.condensed)
                                                    .contentTransition(.numericText(countsDown: false))
                                                Spacer()
                                                Text("\((userData.airlineReputation * 100).withCommas)% known")
                                                    .fontWidth(.condensed)
                                                    .contentTransition(.numericText(countsDown: true))
                                            }
                                        }
                                        
                                        HStack {
                                            Text("Balance: $\(userData.accountBalance.withCommas)")
                                                .fontWidth(.condensed)
                                                .contentTransition(.numericText(countsDown: false))
                                            Spacer()
                                        }
                                        
                                        HStack {
                                            Button {
#if targetEnvironment(macCatalyst)
                                                openWindow(id: "fuel")
#else
                                                openFuelWindow = true
#endif
                                            } label: {
                                                HStack {
                                                    Spacer()
                                                    Image(systemName: "fuelpump")
                                                    Spacer()
                                                }
                                            }
                                            .adaptiveButtonStyle()
                                            .hoverEffect()
                                            
                                            Button {
                                                print("Open")
#if targetEnvironment(macCatalyst)
                                                openWindow(id: "upgrade")
#else
                                                openUserUpgradeView = true
#endif
                                            } label: {
                                                HStack {
                                                    Spacer()
                                                    Image(systemName: "person.text.rectangle")
                                                    Spacer()
                                                }
                                            }
                                            .adaptiveButtonStyle()
                                            .hoverEffect()
                                            
                                            Button {
#if targetEnvironment(macCatalyst)
                                                openWindow(id: "shop")
#else
                                                openShopView = true
#endif
                                            } label: {
                                                HStack {
                                                    Spacer()
                                                    Image(systemName: "cart")
                                                    Spacer()
                                                }
                                            }
                                            .adaptiveButtonStyle()
                                            .hoverEffect()
                                            
                                            Button {
#if targetEnvironment(macCatalyst)
                                                openWindow(id: "settings")
#else
                                                openAIView = true
#endif
                                            } label: {
                                                HStack {
                                                    Spacer()
                                                    Image(systemName: "apple.intelligence")
                                                    Spacer()
                                                }
                                            }
                                            .adaptiveButtonStyle()
                                            .hoverEffect()
                                            
                                            Button {
#if targetEnvironment(macCatalyst)
                                                openWindow(id: "settings")
#else
                                                openSettings = true
#endif
                                            } label: {
                                                HStack {
                                                    Spacer()
                                                    Image(systemName: "gearshape.2")
                                                    Spacer()
                                                }
                                            }
                                            .adaptiveButtonStyle()
                                            .hoverEffect()
                                            
                                        }
                                    }
                                }
                                //                            .transition(.slide)
                                .transition(.move(edge: .leading))
                            } else {
                                selectedJetView()
                                    .transition(.move(edge: .trailing))
                                    .frame(height: .infinity, alignment: .top)
                                
                                    .onAppear {
                                        print(userData.xp)
                                        print(userData.currentLevel)
                                        print(userData.levels)
                                    }
                            }
                            
                        }
                        .padding()
                        .frame(width: CGFloat(sidebarWidth + 10), height: reader.size.height - 75)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                    }
                    Rectangle()
                        .frame(width: 10)
                        .foregroundStyle(.clear)
                        .contentShape(Rectangle())
                        .gesture(DragGesture().onChanged { value in
                            let newWidth = CGFloat(self.sidebarWidth) + value.translation.width
                            self.sidebarWidth = Float(CGFloat(min(600, max(350, newWidth))))
                        })
                        .onChange(of: reader.size.width) {
                            if sidebarWidth > Float(reader.size.width) - 40 {
                                sidebarWidth = Float(reader.size.width) - 40
                            }
                        }
                        .onChange(of: sidebarWidth) {
                            if sidebarWidth > Float(reader.size.width) - 40 {
                                sidebarWidth = Float(reader.size.width) - 40
                            }
                        }
                }
                .padding()
            }
            
            if showTakeoffPopup {
                ShowDepartureDonePopupView(showDeparturePopupView: $showTakeoffPopup, departureDoneSuccessfullyItemsToShow: takeoffItems!)
                    .transition(.blurReplace)
                    .zIndex(1)
            }
        }
        .statusBarHidden(true)
        .ignoresSafeArea()
        .onChange(of: showTakeoffPopup) { newValue in
            if newValue {
                Task { @MainActor in
                    try? await Task.sleep(nanoseconds: 1_500_000_000*2)
                    withAnimation {
                        showTakeoffPopup = false
                    }
                }
            }
        }
        .sheet(isPresented: $openSettings) {
            SettingsView(modifiableUserData: $userData)
        }
        .fullScreenCover(isPresented: $airportSelector) {
            AirportPickerView(airportSelected: Binding {
                return userData.planes[selectedJet!].assignedRoute!.arrivalAirport
            } set: {
                userData.planes[selectedJet!].assignedRoute!.arrivalAirport = $0
            }, airportSelectionText: "Select your destination airport",
                              userData: userData,
                              maxRange: AircraftDatabase.shared.allAircraft.first(where: { $0.id == $userData.wrappedValue.planes[selectedJet!].aircraftID })!.maxRange,
                              startAirport: userData.planes[selectedJet!].currentAirportLocation,
                              finishedPickingScreen: Binding {
                return !openSettings
            } set: {
                print($0)
                if $0 {
                    print("check")
                    if #available(iOS 18, *) {
                        openSettings = false
                    } else {
                        openWindow(id: "settings")
                    }
                }
            })
        }
        .fullScreenCover(isPresented: $openUserUpgradeView) {
            UserUpgradeView(modifiableUserData: $userData)
                .onAppear {
                    print("Open")
                }
        }
        .fullScreenCover(isPresented: $openFuelWindow) {
            FuelPriceView(modifiableUserData: $userData)
        }
        .fullScreenCover(isPresented: $openShopView) {
            ShopView(modifiableUserData: $userData)
        }
        .fullScreenCover(isPresented: $openAIView) {
            AiView(userData: $userData)
        }
        .onChange(of: userData.levels) {
            withAnimation {
                userData.currentLevel = userData.levels
            }
        }
        .onAppear {
            userData.currentLevel = userData.levels
        }
    }
}

#Preview {
    MapManagerView(userData: .constant(testUserDataWithFlyingPlanes))
}

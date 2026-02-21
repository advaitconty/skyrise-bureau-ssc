//
//  SelectedJetView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/12/25.
//

import SwiftUI
import UIKit

extension UIDevice {
    var isPad: Bool { userInterfaceIdiom == .pad }
    var isPhone: Bool { userInterfaceIdiom == .phone }
    var isMac: Bool { userInterfaceIdiom == .mac }
}


extension MapManagerView {
    func itemToChange(symbol: String, priceToChange: Binding<Double>) -> some View {
        VStack {
            if #available(iOS 26.0, *) {
                HStack {
                    Image(systemName: symbol)
                    TextField(priceToChange.wrappedValue.withCommas, value: priceToChange, format: .currency(code: "USD"))
                        .fontWidth(.condensed)
                        .textFieldStyle(.plain)
                        .contentTransition(.numericText(countsDown: true))
                }
                .padding()
                .glassEffect()
            } else {
                HStack {
                    Image(systemName: symbol)
                    TextField(priceToChange.wrappedValue.withCommas, value: priceToChange, format: .currency(code: "USD"))
                        .fontWidth(.condensed)
                        .textFieldStyle(.roundedBorder)
                }
            }
        }
    }
    
    func selectedJetView() -> some View {
        VStack {
            HStack {
                if #available(iOS 26.0, *) {
                    Button {
                        withAnimation {
                            selectedJet = nil
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .frame(width: 10, height: 10)
                    }
                    .buttonStyle(.glass)
                    .hoverEffect()
                } else {
                    Button {
                        withAnimation {
                            selectedJet = nil
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .frame(width: 10, height: 10)
                    }
                    .buttonStyle(.bordered)
                    .hoverEffect()
                }
                Text("\(userData.planes[selectedJet!].registration) ")
                    .fontWidth(.compressed)
                +
                Text("(\(userData.planes[selectedJet!].aircraftname))")
                    .fontWidth(.condensed)
                Spacer()
                Text(userData.planes[selectedJet!].aircraftID)
                    .fontWidth(.expanded)
            }
            
            Image(userData.planes[selectedJet!].aircraftID)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
            
            
            VStack {
                if !userData.planes[selectedJet!].isAirborne && userData.planes[selectedJet!].condition >= 0.15 {
                    VStack {
                        ProgressView(value: userData.planes[selectedJet!].condition) {
                            HStack {
                                Text("Condition: \((userData.planes[selectedJet!].condition * 100).withCommas)%")
                                    .fontWidth(.condensed)
                                Spacer()
                                if !userData.planes[selectedJet!].inMaintainance && userData.planes[selectedJet!].condition >= 0.15  {
                                    Button {
                                        userData.planes[selectedJet!].setJetUnderMaintainance($userData)
                                        let notificationsManager = NotificationsManager()
                                        notificationsManager.schedule(notificationType: .maintainanceEnd, planeInvolved: userData.planes[selectedJet!], date: userData.planes[selectedJet!].endMaintainanceDate!, userData: userData)
                                    } label: {
                                        Text("Repair")
                                            .fontWidth(.condensed)
                                    }
                                    .adaptiveButtonStyle()
                                    .disabled(AircraftDatabase.shared.allAircraft.first(where: { $0.id == userData.planes[selectedJet!].aircraftID })!.maintenanceCostPerHour * userData.planes[selectedJet!].lastHoursOfPlaneDuringMaintainance > userData.accountBalance)
                                }
                            }
                        }
                    }
                }
                
                if userData.planes[selectedJet!].assignedRoute != nil {
                    if userData.planes[selectedJet!].isAirborne {
                        VStack {
                            HStack {
                                Text("Plane is flying from \(userData.planes[selectedJet!].assignedRoute!.originAirport.reportCorrectCodeForUserData(userData)) to \(userData.planes[selectedJet!].assignedRoute!.arrivalAirport.reportCorrectCodeForUserData(userData))")
                                    .fontWidth(.condensed)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            HStack {
                                TimelineView(.periodic(from: .now, by: 1)) { context in
                                    Text("Landing in \(userData.planes[selectedJet!].timeTakenForJetToReturn(context.date))")
                                        .fontWidth(.condensed)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    } else {
                        Text("Plane is currently on the ground at \(userData.planes[selectedJet!].currentAirportLocation!.reportCorrectCodeForUserData(userData)). Assigned to fly from \(userData.planes[selectedJet!].assignedRoute!.originAirport.reportCorrectCodeForUserData(userData)) to \(userData.planes[selectedJet!].assignedRoute!.arrivalAirport.reportCorrectCodeForUserData(userData))")
                            .fontWidth(.condensed)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                } else {
                    HStack {
                        Text("No assigned route. Currently at \(userData.planes[selectedJet!].currentAirportLocation!.reportCorrectCodeForUserData(userData))")
                            .fontWidth(.condensed)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                if !userData.planes[selectedJet!].isAirborne && !userData.planes[selectedJet!].inMaintainance {
                    HStack {
                        if #available(iOS 26.0, *) {
                            Button {
                                if userData.planes[selectedJet!].assignedRoute == nil {
                                    userData.planes[selectedJet!].assignedRoute = Route(originAirport: userData.planes[selectedJet!].currentAirportLocation!, arrivalAirport: getRandomAirportWithinPlaneRange(maxRange: AircraftDatabase.shared.allAircraft.first(where: { $0.id == userData.planes[selectedJet!].aircraftID })!.maxRange, startAirport: userData.planes[selectedJet!].currentAirportLocation!))
                                }
                                airportSelector = true
                            } label: {
                                Spacer()
                                Image(systemName: "mappin")
                                Text(userData.planes[selectedJet!].assignedRoute == nil ? "Assign flight plan" : "Edit flight plan")
                                    .fontWidth(.condensed)
                                Spacer()
                            }
                            .buttonStyle(.glassProminent)
                            .hoverEffect()
                        } else {
                            
                            Button {
                                airportSelector = true
                            } label: {
                                Spacer()
                                Image(systemName: "mappin")
                                Text(userData.planes[selectedJet!].assignedRoute == nil ? "Assign flight plan" : "Edit flight plan")
                                    .fontWidth(.condensed)
                                Spacer()
                            }
                            .buttonStyle(.borderedProminent)
                            .hoverEffect()
                        }
                    }
                }
                
                if userData.planes[selectedJet!].assignedRoute != nil && !userData.planes[selectedJet!].isAirborne && !userData.planes[selectedJet!].inMaintainance {
                    VStack {
                        HStack {
                            Text("Modify pricing")
                                .fontWidth(.expanded)
                            Spacer()
                        }
                        itemToChange(symbol: "carseat.right", priceToChange: $userData.planes[selectedJet!].assignedPricing.economy)
                        
                        itemToChange(symbol: "star", priceToChange: $userData.planes[selectedJet!].assignedPricing.premiumEconomy)
                        
                        itemToChange(symbol: "briefcase", priceToChange: $userData.planes[selectedJet!].assignedPricing.business)
                        
                        itemToChange(symbol: "crown", priceToChange: $userData.planes[selectedJet!].assignedPricing.first)
                        
                        if #available(iOS 26.0, *) {
                            Button {
                                let db = AirportDatabase()
                                let distance = db.calculateDistance(from: userData.planes[selectedJet!].assignedRoute!.originAirport, to: userData.planes[selectedJet!].assignedRoute!.arrivalAirport)
                                let reasonablePricingForAirline = PricingConfig(
                                    economy: Double(predictorModel.predictPricePerKM(rating: userData.airlineReputation, seatClass: .economy) * Double(distance)),
                                    premiumEconomy: Double(predictorModel.predictPricePerKM(rating: userData.airlineReputation, seatClass: .premiumEconomy) * Double(distance)),
                                    business: Double(predictorModel.predictPricePerKM(rating: userData.airlineReputation, seatClass: .business) * Double(distance)),
                                    first: Double(predictorModel.predictPricePerKM(rating: userData.airlineReputation, seatClass: .first) * Double(distance))
                                )
                                withAnimation {
                                    userData.planes[selectedJet!].assignedPricing.economy = reasonablePricingForAirline.economy
                                    userData.planes[selectedJet!].assignedPricing.premiumEconomy = reasonablePricingForAirline.premiumEconomy
                                    userData.planes[selectedJet!].assignedPricing.business = reasonablePricingForAirline.business
                                    userData.planes[selectedJet!].assignedPricing.first = reasonablePricingForAirline.first
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "chart.xyaxis.line")
                                    Text("AutoPrice")
                                        .fontWidth(.condensed)
                                    Spacer()
                                }
                            }
                            .padding(2)
                            .buttonStyle(.glassProminent)
                            .hoverEffect()
                        } else {
                            Button {
                                let db = AirportDatabase()
                                let distance = db.calculateDistance(from: userData.planes[selectedJet!].assignedRoute!.originAirport, to: userData.planes[selectedJet!].assignedRoute!.arrivalAirport)
                                let reasonablePricingForAirline = PricingConfig(
                                    economy: Double(predictorModel.predictPricePerKM(rating: userData.airlineReputation, seatClass: .economy) * Double(distance)),
                                    premiumEconomy: Double(predictorModel.predictPricePerKM(rating: userData.airlineReputation, seatClass: .premiumEconomy) * Double(distance)),
                                    business: Double(predictorModel.predictPricePerKM(rating: userData.airlineReputation, seatClass: .business) * Double(distance)),
                                    first: Double(predictorModel.predictPricePerKM(rating: userData.airlineReputation, seatClass: .first) * Double(distance))
                                )
                                withAnimation {
                                    userData.planes[selectedJet!].assignedPricing.economy = reasonablePricingForAirline.economy
                                    userData.planes[selectedJet!].assignedPricing.premiumEconomy = reasonablePricingForAirline.premiumEconomy
                                    userData.planes[selectedJet!].assignedPricing.business = reasonablePricingForAirline.business
                                    userData.planes[selectedJet!].assignedPricing.first = reasonablePricingForAirline.first
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "chart.xyaxis.line")
                                    Text("AutoPrice")
                                        .fontWidth(.condensed)
                                    Spacer()
                                }
                            }
                            .padding(2)
                            .buttonStyle(.borderedProminent)
                            .hoverEffect()
                        }
                        
                        if userData.planes[selectedJet!].condition >= 0.15 {
                            HStack {
                                Text("Depart jet")
                                    .fontWidth(.condensed)
                                Spacer()
                                
                                Button {
                                    let departureStatus = userData.planes[selectedJet!].departJet($userData)
                                    print(departureStatus)
                                    if departureStatus.departedSuccessfully {
                                        takeoffItems = DepartureDoneSuccessfullyItemsToShow(planesTakenOff: [userData.planes[selectedJet!]],
                                                                                            economyPassenegersServed: departureStatus.seatsUsedInPlane!.economy,
                                                                                            premiumEconomyPassenegersServed: departureStatus.seatsUsedInPlane!.premiumEconomy,
                                                                                            businessPassengersServed: departureStatus.seatsUsedInPlane!.business,
                                                                                            firstClassPassengersServed: departureStatus.seatsUsedInPlane!.first,
                                                                                            maxEconomyPassenegersServed: departureStatus.seatingConfigOfJet!.economy,
                                                                                            maxPremiumEconomyPassenegersServed: departureStatus.seatingConfigOfJet!.premiumEconomy,
                                                                                            maxBusinessPassengersServed: departureStatus.seatingConfigOfJet!.business,
                                                                                            maxFirstClassPassengersServed: departureStatus.seatingConfigOfJet!.first,
                                                                                            moneyMade: departureStatus.moneyMade!)
                                        withAnimation {
                                            showTakeoffPopup = true
                                        }
                                    }
                                } label: {
                                    Text("Depart")
                                        .fontWidth(.condensed)
                                }
                                .adaptiveProminentButtonStyle()
                            }
                        } else if userData.planes[selectedJet!].condition <= 0.15 {
                            HStack {
                                Text("Plane cannot fly due to poor condition")
                                    .fontWidth(.condensed)
                                Spacer()
                                if userData.accountBalance > AircraftDatabase.shared.allAircraft.first(where: { userData.planes[selectedJet!].aircraftID == $0.modelCode })!.maintenanceCostPerHour * (userData.planes[selectedJet!].hoursFlown - userData.planes[selectedJet!].lastHoursOfPlaneDuringMaintainance) {
                                    Button {
                                        withAnimation {
                                            userData.accountBalance -= AircraftDatabase.shared.allAircraft.first(where: { userData.planes[selectedJet!].aircraftID == $0.modelCode })!.maintenanceCostPerHour * (userData.planes[selectedJet!].hoursFlown - userData.planes[selectedJet!].lastHoursOfPlaneDuringMaintainance)
                                        }
                                    } label: {
                                        Text("$\((AircraftDatabase.shared.allAircraft.first(where: { userData.planes[selectedJet!].aircraftID == $0.modelCode })!.maintenanceCostPerHour * (userData.planes[selectedJet!].hoursFlown - userData.planes[selectedJet!].lastHoursOfPlaneDuringMaintainance)).withCommas)")
                                    }
                                }
                            }
                        }
                    }
                } else if userData.planes[selectedJet!].endMaintainanceDate != nil {
                    TimelineView(.periodic(from: .now, by: 1.0))  { context in
                        HStack {
                            Text("\(userData.planes[selectedJet!].timeTakenForJetToGetOutOfMaintainance(context.date)) to finish maintainace")
                                .fontWidth(.condensed)
                                .contentTransition(.numericText(countsDown: true))
                            Spacer()
                        }
                    }
                }
            }
            Spacer()
        }
    }
}

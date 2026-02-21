//
//  PlaneConfiguratorView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/12/25.
//

import SwiftUI

extension ShopView {
    func aircraftImage(_ plane: Aircraft) -> some View {
        ZStack(alignment: .bottomTrailing) {
            Image(plane.modelCode)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            Button {
                aircraftCreditInformation = credits.first(where: { $0.imageItem == plane.modelCode })!
            } label: {
                Image(systemName: "info.circle")
            }
            .adaptiveButtonStyle()
            .popover(item: $aircraftCreditInformation) { creditInfo in
                VStack(alignment: .leading) {
                    Text("Shot by \(creditInfo.creatorName) \(creditInfo.creditSource == .fireentity ? "(@fireentity on GitHub)" : "")")
                        .fontWidth(.expanded)
                    Text("Description: \(creditInfo.attributedFor)")
                        .fontWidth(.condensed)
                    Divider()
                    Text("Available under the \(creditInfo.creditSource != .pixabay ? "Creative Commons (CC BY-SA 2.0)" : "Pixaby License")")
                        .fontWidth(.condensed)
                    Text("Images have been compressed and cropped for use in this game.")
                        .fontWidth(.condensed)
                    
                    HStack {
                        if creditInfo.creditSource == .wikimedia || creditInfo.creditSource == .flickr {
                            Button {
                                if let url = URL(string: "https://creativecommons.org/licenses/by-sa/2.0/deed.en") {
                                    openURL(url)
                                }
                            } label: {
                                Text("Creative Commons CC BY-SA 2.0 License")
                                    .fontWidth(.condensed)
                            }
                            .adaptiveButtonStyle()
                            .hoverEffect()
                        }
                        
                        if creditInfo.creditSource != .personal {
                            Button {
                                openURL(creditInfo.urlLinkToOriginal)
                            } label: {
                                Text(creditInfo.creditSource != .fireentity ? "Original image" : "Image creator's GitHub")
                                    .fontWidth(.condensed)
                            }
                            .adaptiveButtonStyle()
                            .hoverEffect()
                        } else {
                            Text("Shot and edited by Advait Contractor (advaitconty)!")
                                .fontWidth(.condensed)
                        }
                    }
                }
                .padding()
            }
        }
    }
    
    func planeConfiguratorView(_ plane: Aircraft) -> some View {
        ScrollView {
            GeometryReader { geo in
                        let isNarrow = geo.size.width < 600
                        
                        Group {
                            if isNarrow {
                                VStack(alignment: .leading, spacing: 16) {
                                    aircraftImage(plane)
                                    infoPanel(plane)
                                }
                            } else {
                                HStack(alignment: .top, spacing: 24) {
                                    aircraftImage(plane)
                                        .frame(width: geo.size.width * 0.4, height: 280)
                                    
                                    infoPanel(plane)
                                        .frame(width: geo.size.width * 0.55)
                                }
                            }
                        }
                    }
                    .frame(minHeight: 400)
            
            VStack {
                
                if modifiableUserData.wrappedValue.accountBalance > plane.purchasePrice {
                    seatingConfiguration()
                        .onAppear {
                            preferedSeatingConfig = plane.defaultSeating
                        }
                    
                    availableAirportPicker()
                    
                    
                    if !showAllSeatsFilled {
                        if showNotAllSeatsFullWarning {
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .symbolRenderingMode(.multicolor)
                                
                                Text("Not all seats are full on this plane. You can fit up to \(-1 * Int(preferedSeatingConfig.seatsUsed) + plane.maxSeats) more economy seats on this jet.")
                                    .fontWidth(.condensed)
                            }
                        }
                        
                        if #available(iOS 26.0, *) {
                            Button {
                                modifiableUserData.wrappedValue.planes.append(FleetItem(aircraftID: plane.modelCode, aircraftname: aircraftName, registration: registration, hoursFlown: 0, seatingLayout: preferedSeatingConfig, kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: airportToDeliverPlaneTo))
                                modifiableUserData.wrappedValue.maintainanceCrew += 3
                                modifiableUserData.wrappedValue.pilots += plane.pilots
                                modifiableUserData.wrappedValue.flightAttendents += plane.flightAttendents
                                modifiableUserData.wrappedValue.amountSpentOnPlanesInTheLastWeek[modifiableUserData.wrappedValue.amountSpentOnPlanesInTheLastWeek.endIndex - 1] = modifiableUserData.wrappedValue.amountSpentOnPlanesInTheLastWeek[modifiableUserData.wrappedValue.amountSpentOnPlanesInTheLastWeek.endIndex - 1] + plane.purchasePrice
                                modifiableUserData.wrappedValue.accountBalance -= plane.purchasePrice
                                dismiss()
                            } label: {
                                Text("Purchase for $\(plane.purchasePrice.withCommas)")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glassProminent)
                            .hoverEffect()
                        } else {
                            Button {
                                modifiableUserData.wrappedValue.planes.append(FleetItem(aircraftID: plane.modelCode, aircraftname: aircraftName, registration: registration, hoursFlown: 0, seatingLayout: preferedSeatingConfig, kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: airportToDeliverPlaneTo))
                                modifiableUserData.wrappedValue.maintainanceCrew += 3
                                modifiableUserData.wrappedValue.pilots += plane.pilots
                                modifiableUserData.wrappedValue.flightAttendents += plane.flightAttendents
                                let lastIdx = modifiableUserData.wrappedValue.amountSpentOnPlanesInTheLastWeek.count - 1
                                if lastIdx >= 0 {
                                    modifiableUserData.wrappedValue.amountSpentOnPlanesInTheLastWeek[lastIdx] += plane.purchasePrice
                                }
                                dismiss()
                            } label: {
                                Text("Purchase for $\(plane.purchasePrice.withCommas)")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.borderedProminent)
                            .hoverEffect()
                        }
                    } else {
                        HStack {
                            Image(systemName: "exclamationmark.octagon.fill")
                                .symbolRenderingMode(.multicolor)
                            Text("Your ideal seating config fair outweighs what this plane can carry. Please try something else.")
                                .fontWidth(.condensed)
                        }
                    }
                } else {
                    HStack {
                        Image(systemName: "exclamationmark.octagon.fill")
                            .symbolRenderingMode(.multicolor)
                        Text("You do not have enough funds to purchase this plane")
                            .fontWidth(.condensed)
                    }
                }
            }
        }
    }
}

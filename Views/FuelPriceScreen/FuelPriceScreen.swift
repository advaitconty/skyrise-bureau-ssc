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
    @Environment(\.dismissWindow) var dismissWindow
    @Environment(\.dismiss) var dismiss
    @Query var userData: [UserData]
    @Environment(\.modelContext) var modelContext
    var modifiableUserData: Binding<UserData>
    
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
                         Text("$\(modifiableUserData.wrappedValue.accountBalance.withCommas)")
                            .font(.title3)
                            .fontWidth(.expanded))
                        .multilineTextAlignment(.trailing)
                        .contentTransition(.numericText(countsDown: true))
                    }
//                    if !checkForMacCatalyst() {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                        .adaptiveButtonStyle()
                        .hoverEffect()
                        .accessibilityLabel("Close fuel purchase screen")
//                    }   targetEnvironment(macCatalyst)
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
                            (Text("$\(Int(modifiableUserData.wrappedValue.currentFuelPrice))")
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
                                modifiableUserData.wrappedValue.currentlyHoldingFuel = modifiableUserData.wrappedValue.currentlyHoldingFuel + Int(amountOfFuelUserWantsToPurchase)
                                modifiableUserData.wrappedValue.accountBalance = modifiableUserData.wrappedValue.accountBalance - modifiableUserData.wrappedValue.currentFuelPrice/1000 * amountOfFuelUserWantsToPurchase
                            }
                            modifiableUserData.wrappedValue.fuelPurchasedByUserAtLastFuelPrice = modifiableUserData.wrappedValue.fuelPurchasedByUserAtLastFuelPrice + modifiableUserData.wrappedValue.currentFuelPrice/1000 * amountOfFuelUserWantsToPurchase
                            modifiableUserData.wrappedValue.amountSpentOnFuelInTheLastWeek[modifiableUserData.wrappedValue.amountSpentOnFuelInTheLastWeek.endIndex - 1] = modifiableUserData.wrappedValue.amountSpentOnFuelInTheLastWeek[modifiableUserData.wrappedValue.amountSpentOnFuelInTheLastWeek.endIndex - 1] + modifiableUserData.wrappedValue.currentFuelPrice/1000 * amountOfFuelUserWantsToPurchase
                        } label: {
                            Spacer()
                            Text("Execute fuel trade")
                                .fontWidth(.condensed)
                            Spacer()
                        }
                        .disabled(buttonDisabledStatus)
                        .adaptiveProminentButtonStyle()
                        .hoverEffect()
                        .accessibilityLabel("Execute fuel trade for \(Int(modifiableUserData.wrappedValue.currentFuelPrice/1000 * amountOfFuelUserWantsToPurchase)) dollars")
                        .accessibilityHint(buttonDisabledStatus ? "Trade cannot be completed" : "Double tap to purchase fuel")
                        
                        
                        /// Current fuel capacity
                        VStack {
                            ProgressView(value: Double(modifiableUserData.wrappedValue.currentlyHoldingFuel)/Double(modifiableUserData.wrappedValue.maxFuelHoldable)) {
                                HStack {
                                    Text("CURRENT \nFUEL HOLD:\n")
                                        .font(.caption)
                                        .fontWidth(.condensed)
                                    Spacer()
                                    Text("\(modifiableUserData.wrappedValue.currentlyHoldingFuel.withCommas)kg/\(modifiableUserData.wrappedValue.maxFuelHoldable.withCommas)kg")
                                        .fontWidth(.expanded)
                                        .multilineTextAlignment(.trailing)
                                        .lineLimit(2, reservesSpace: true)
                                        .contentTransition(.numericText(countsDown: true))
                                }
                            }
                        }
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("Current fuel hold: \(modifiableUserData.wrappedValue.currentlyHoldingFuel.withCommas) kilograms out of \(modifiableUserData.wrappedValue.maxFuelHoldable.withCommas) kilograms")
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
            let item = modifiableUserData.wrappedValue.lastFewFuelPricesForGraph
            lastFewFuelPriceItem = convertFuelPricesToChartItems(item)
        }
    }
}

var testUserDataModifiable = testUserData

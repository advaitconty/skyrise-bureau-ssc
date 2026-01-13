//
//  TextFieldItem.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 26/11/25.
//

import SwiftUI

extension FuelPriceView {
    func textFieldItem() -> some View {
        VStack(spacing: 0) {
            if #available(iOS 26.0, macOS 26.0, *) {
                HStack {
                    Text("Amount to order:")
                        .fontWidth(.condensed)
                    TextField("1000", value: $amountOfFuelUserWantsToPurchase, format: .number)
                        .fontWidth(.condensed)
                        .multilineTextAlignment(.trailing)
                        .onChange(of: amountOfFuelUserWantsToPurchase) {
                            if modifiableUserData.wrappedValue.maxFuelHoldable < modifiableUserData.wrappedValue.currentlyHoldingFuel + Int(amountOfFuelUserWantsToPurchase) && modifiableUserData.wrappedValue.accountBalance - modifiableUserData.wrappedValue.currentFuelPrice/1000 * amountOfFuelUserWantsToPurchase < 0 {
                                withAnimation {
                                    exceedMax = true
                                    notEnoughBalance = true
                                }
                            } else {
                                if modifiableUserData.wrappedValue.maxFuelHoldable < modifiableUserData.wrappedValue.currentlyHoldingFuel + Int(amountOfFuelUserWantsToPurchase) {
                                    withAnimation {
                                        exceedMax = true
                                    }
                                } else if modifiableUserData.wrappedValue.accountBalance - modifiableUserData.wrappedValue.currentFuelPrice / 1000 * amountOfFuelUserWantsToPurchase < 0 {
                                    withAnimation {
                                        notEnoughBalance = true
                                    }
                                } else {
                                    withAnimation {
                                        exceedMax = false
                                        notEnoughBalance = false
                                    }
                                }
                            }
                        }
                    Text("kg")
                        .fontWidth(.condensed)
                }
                .padding()
                .glassEffect()
            } else {
                HStack {
                    Text("Amount to order:")
                        .fontWidth(.condensed)
                    TextField("1000", value: $amountOfFuelUserWantsToPurchase, format: .number)
                        .fontWidth(.condensed)
                        .multilineTextAlignment(.trailing)
                        .onChange(of: amountOfFuelUserWantsToPurchase) {
                            if modifiableUserData.wrappedValue.maxFuelHoldable < modifiableUserData.wrappedValue.currentlyHoldingFuel + Int(amountOfFuelUserWantsToPurchase) && modifiableUserData.wrappedValue.accountBalance - modifiableUserData.wrappedValue.currentFuelPrice/1000 * amountOfFuelUserWantsToPurchase < 0 {
                                withAnimation {
                                    exceedMax = true
                                    notEnoughBalance = true
                                }
                            } else {
                                if modifiableUserData.wrappedValue.maxFuelHoldable < modifiableUserData.wrappedValue.currentlyHoldingFuel + Int(amountOfFuelUserWantsToPurchase) {
                                    withAnimation {
                                        exceedMax = true
                                    }
                                } else if modifiableUserData.wrappedValue.accountBalance - modifiableUserData.wrappedValue.currentFuelPrice / 1000 * amountOfFuelUserWantsToPurchase < 0 {
                                    withAnimation {
                                        notEnoughBalance = true
                                    }
                                } else {
                                    withAnimation {
                                        exceedMax = false
                                        notEnoughBalance = false
                                    }
                                }
                            }
                        }
                    Text("kg")
                        .fontWidth(.condensed)
                }

            }
        }
    }
}

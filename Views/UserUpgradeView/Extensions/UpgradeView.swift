//
//  UpgradeView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 3/12/25.
//

import SwiftUI

extension UserUpgradeView {
    func upgradeView() -> some View {
        VStack {
            HStack {
                Text("UPGRADES")
                    .font(.title3)
                    .fontWidth(.expanded)
                Spacer()
            }
            // MARK: Holding fuel tank capacity
            HStack {
                (Text("HOLDING FUEL TANK UPGRADE\n")
                    .fontWidth(.expanded)
                +
                Text("Increase your maximum fuel capacity. Your current maximum is \(modifiableUserData.wrappedValue.maxFuelHoldable.withCommas)kg. Upgrading lets you buy and store more fuel when prices are cheap.")
                    .fontWidth(.condensed))
                .contentTransition(.numericText(countsDown: true))
                Spacer()
                
                Button {
                    withAnimation {
                        modifiableUserData.wrappedValue.accountBalance -= Double((modifiableUserData.wrappedValue.maxFuelHoldable - 4000000) * 10)
                        modifiableUserData.wrappedValue.xpPoints -= (modifiableUserData.wrappedValue.maxFuelHoldable - 4000000) / 1000000
                        modifiableUserData.wrappedValue.maxFuelHoldable += 1000000
                    }
                } label: {
                    VStack {
                        Text("+1,000,000kg")
                            .fontWidth(.condensed)
                        Text("$\(((modifiableUserData.wrappedValue.maxFuelHoldable - 4000000) * 10).withCommas) and \(((modifiableUserData.wrappedValue.maxFuelHoldable - 4000000)/1000000)) XP Point\(((modifiableUserData.wrappedValue.maxFuelHoldable - 4000000)/1000000).plu())")
                            .fontWidth(.compressed)
                    }
                    .padding()
                }
                .disabled(
                    Double((modifiableUserData.wrappedValue.maxFuelHoldable - 4_000_000) * 10)
                        > modifiableUserData.wrappedValue.accountBalance
                    ||
                    ((modifiableUserData.wrappedValue.maxFuelHoldable - 4_000_000) / 1_000_000)
                        > modifiableUserData.wrappedValue.xpPoints
                )
                .adaptiveButtonStyle()
                .hoverEffect()
            }
            
            // MARK: Repuation boost
            HStack {
                (Text("PERMENANT REPUTATION BOOST\n")
                    .fontWidth(.expanded)
                +
                 Text("Permenantly increase your base reputation, allowing you to attract more passengers on your flight without having to consistently keep an active marketing campaign. Current base reputation: \((modifiableUserData.wrappedValue.baseReputation * 100).withCommas)%.")
                    .fontWidth(.condensed))
                .contentTransition(.numericText(countsDown: true))
                Spacer()
                
                Button {
                    withAnimation {
                        modifiableUserData.wrappedValue.accountBalance -= Double(((modifiableUserData.wrappedValue.baseReputation - 0.55) / 5 * 5000000000))
                        modifiableUserData.wrappedValue.xpPoints -= Int((modifiableUserData.wrappedValue.baseReputation - 0.55) / 5 * 500)
                        modifiableUserData.wrappedValue.baseReputation += 0.05
                        if !modifiableUserData.wrappedValue.campaignRunning {
                            modifiableUserData.wrappedValue.airlineReputation = modifiableUserData.wrappedValue.baseReputation
                        }
                    }
                } label: {
                    VStack {
                        Text("+5%")
                            .fontWidth(.condensed)
                        Text("$\(((modifiableUserData.wrappedValue.baseReputation - 0.55) / 5 * 5000000000) .withCommas) and \(((modifiableUserData.wrappedValue.baseReputation - 0.55) / 5 * 500).withCommas) XP Point\(((Int(modifiableUserData.wrappedValue.baseReputation - 0.55) / 5 * 500)).plu())")
                            .fontWidth(.compressed)
                    }
                    .padding()
                }
                .disabled(
                    Int((modifiableUserData.wrappedValue.baseReputation - 0.55) / 5 * 5000000000) > Int(modifiableUserData.wrappedValue.accountBalance) ||
                    modifiableUserData.wrappedValue.xpPoints < Int(modifiableUserData.wrappedValue.baseReputation - 0.55) / 5 * 500
                )
                .adaptiveButtonStyle()
                .hoverEffect()
            }
            
            Spacer()
        }
    }
}

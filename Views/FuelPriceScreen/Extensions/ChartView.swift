//
//  ChartView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 26/11/25.
//

import SwiftUI
import Charts

extension FuelPriceView {
    func chartView() -> some View {
        VStack {
            HStack {
                Text("Price over last 10 min")
                    .font(.caption)
                    .fontWidth(.expanded)
                Spacer()
            }
            Chart(lastFewFuelPriceItem, id: \.id) { price in
                LineMark(x: .value("Fuel", price.hour), y: .value("Fuel Price", price.fuelPrice))
                    .interpolationMethod(.monotone)
            }
            .accessibilityLabel("Fuel price chart over last 10 minutes")
            HStack {
                if let maxItem = lastFewFuelPriceItem.max(by: { a, b in
                    a.fuelPrice < b.fuelPrice
                }) {
                    (Text("MAX:\n")
                        .font(.caption)
                        .fontWidth(.condensed)
                    +
                    Text("$\(String(format: "%.2f", maxItem.fuelPrice))")
                        .font(.headline)
                        .fontWeight(.regular)
                        .fontWidth(.expanded))
                        .contentTransition(.numericText(countsDown: true))
                }
                Spacer()
                if let minItem = lastFewFuelPriceItem.max(by: { a, b in
                    a.fuelPrice > b.fuelPrice
                }) {
                    (Text("MIN:\n")
                        .font(.caption)
                        .fontWidth(.condensed)
                    +
                    Text("$\(String(format: "%.2f", minItem.fuelPrice))")
                        .font(.headline)
                        .fontWeight(.regular)
                        .fontWidth(.expanded))
                        .contentTransition(.numericText(countsDown: true))
                }
                Spacer()
                (Text("VOLATILITY:\n")
                    .font(.caption)
                    .fontWidth(.condensed)
                +
                 Text("\(volatilityCalculator(modifiableUserData.wrappedValue.lastFewFuelPricesForGraph))%")
                    .font(.headline)
                    .fontWeight(.regular)
                    .fontWidth(.expanded))
                .contentTransition(.numericText(countsDown: true))
            }
        }
    }
}

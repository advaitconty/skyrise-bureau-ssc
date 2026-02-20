//
//  FinancesView.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 20/2/26.
//

import SwiftUI

extension UserUpgradeView {
    func financesView() -> some View {
        VStack {
            HStack {
                Text("FINANCES")
                    .font(.title3)
                    .fontWidth(.expanded)
                Spacer()
            }
            Table(modifiableUserData.wrappedValue.tableInformationForFinances) {
                TableColumn(
                    Text("Day")
                        .font(.headline)
                        .fontWidth(.expanded)
                ) { row in
                    Text(row.day)
                        .fontWidth(.expanded)
                }
                TableColumn(
                    Text("Fuel Expenses")
                        .font(.headline)
                        .fontWidth(.expanded)
                ) { row in
                    Text("$\(row.amountSpentOnFuel.withCommas)")
                        .font(.body)
                        .fontWidth(.condensed)
                }
                TableColumn(Text("Plane Purchases")
                    .font(.headline)
                    .fontWidth(.expanded)
                ) { row in
                    Text(row.amountSpentOnPlanes.withCommas)
                        .font(.body)
                        .fontWidth(.condensed)
                }
                TableColumn(Text("Other Expenses")
                    .font(.headline)
                    .fontWidth(.expanded)
                ) { row in
                    Text(row.amountSpentOnOtherStuff.withCommas)                        .font(.body)
                        .fontWidth(.condensed)
                }
                TableColumn(Text("Income")
                    .font(.headline)
                    .fontWidth(.expanded)
                ) { row in
                    Text(row.amountMadeThatDay.withCommas)                        .font(.body)
                        .fontWidth(.condensed)
                }
                TableColumn(Text("EBITDA")
                    .font(.headline)
                    .fontWidth(.expanded)
                ) { row in
                    Text(row.ebitdaForThatDay.withCommas)                        .font(.body)
                        .fontWidth(.condensed)
                }
            }
            Spacer()
        }
    }
}

#Preview(traits: .landscapeLeft) {
    UserUpgradeView(showAirportPickerView: true, selectedAirport: AirportDatabase.shared.allAirports.first!, modifiableUserData: .constant(testUserDataEndgame), screen: 4)
}

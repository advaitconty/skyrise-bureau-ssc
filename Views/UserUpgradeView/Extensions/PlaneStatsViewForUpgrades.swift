//
//  planeStatsView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 20/11/25.
//

import SwiftUI

extension UserUpgradeView {
    func planeItemView(_ plane: Binding<FleetItem>) -> some View {
        VStack {
            HStack {
                Image(systemName: "pencil.line")
                    .font(.subheadline)
                
                TextField("Aircraft Name", text: plane.aircraftname, axis: .vertical)
                    .textFieldStyle(.plain)
                    .font(.subheadline)
                    .fontWidth(.expanded)
            }
            
            Image(plane.aircraftID.wrappedValue)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 5.0))
            
            ProgressView(value: plane.condition.wrappedValue) {
                HStack {
                    Text("Condition")
                    Spacer()
                    Text("\((plane.condition.wrappedValue * 100).withCommas)%")
                }
                
                .font(.caption)
                .fontWidth(.condensed)
            }
            
            HStack {
                Text(plane.aircraftID.wrappedValue)
                    .font(.caption)
                    .fontWidth(.condensed)
                Spacer()
                TextField("Registration", text: plane.registration)
                    .fontWidth(.condensed)
                    .textFieldStyle(.plain)
                    .font(.caption)
                    .multilineTextAlignment(.trailing)
                    .fixedSize()
                
                Image(systemName: "pencil.line")
                    .font(.caption)
            }
            Text("\(Int(plane.hoursFlown.wrappedValue).withCommas)h flown - \(plane.isAirborne.wrappedValue ? "currently flying" : plane.currentAirportLocation.wrappedValue.map { "at \($0.reportCorrectCodeForUserData(modifiableUserData.wrappedValue))" } ?? "unknown location")")
                .font(.caption)
                .fontWidth(.condensed)
        }
        .padding()
        .frame(width: 200, height: 250)
        .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
    }
    
    func planeStatsViewForUpgrades() -> some View {
        VStack {
            HStack {
                Text("\(modifiableUserData.wrappedValue.planes.count) Airplanes owned".uppercased())
                    .fontWidth(.expanded)
                Spacer()
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(modifiableUserData.planes, id: \.id) { $plane in
                        planeItemView($plane)
                    }
                }
            }
        }
    }
}

//
//  PilotsAndAttendentsView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 20/11/25.
//

import SwiftUI
import Foundation

extension UserUpgradeView {
    func salaryViewItem() -> some View {
        HStack {
            VStack {
                Text("PILOTS")
                    .font(.caption2)
                    .fontWidth(.expanded)
                    .multilineTextAlignment(.center)
                Spacer()
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 36))
                Text("$\(modifiableUserData.wrappedValue.weeklyPilotSalary.withCommas)/week")
                    .fontWidth(.condensed)
                    .contentTransition(.numericText(countsDown: true))
                Text("\(String(Int(modifiableUserData.wrappedValue.pilotHappiness * 100)))%")
                    .fontWidth(.condensed)
                    .contentTransition(.numericText(countsDown: true))
                Spacer()
                /// Pilot salary logic
                /// To implement in v1
                HStack {
                    Button {
                        var adder: Double
                        if modifiableUserData.wrappedValue.pilotHappiness != 1 {
                             adder = Double.random(in: 0.01...0.05)
                            while adder + modifiableUserData.wrappedValue.pilotHappiness > 1 {
                                adder = Double.random(in: 0.01...0.05)
                            }
                        } else {
                            adder = 0
                        }
                        withAnimation {
                            modifiableUserData.wrappedValue.weeklyPilotSalary = modifiableUserData.wrappedValue.weeklyPilotSalary + 50
                            modifiableUserData.wrappedValue.pilotHappiness = modifiableUserData.wrappedValue.pilotHappiness + adder
                        }
                    } label: {
                        Spacer()
                        Image(systemName: "arrowtriangle.up")
                        Spacer()
                    }
                    .adaptiveProminentButtonStyle()
                    .hoverEffect()
                    .tint(.green)
                    
                    Button {
                        var adder: Double
                        if modifiableUserData.wrappedValue.pilotHappiness != 1 {
                             adder = Double.random(in: 0.01...0.05)
                            while adder + modifiableUserData.wrappedValue.pilotHappiness > 1 {
                                adder = Double.random(in: 0.01...0.05)
                            }
                        } else {
                            adder = 0
                        }
                        withAnimation {
                            modifiableUserData.wrappedValue.weeklyPilotSalary = modifiableUserData.wrappedValue.weeklyPilotSalary - 50
                            modifiableUserData.wrappedValue.pilotHappiness = modifiableUserData.wrappedValue.pilotHappiness - adder
                        }
                    } label: {
                        Spacer()
                        Image(systemName: "arrowtriangle.down")
                        Spacer()
                    }
                    .adaptiveProminentButtonStyle()
                    .hoverEffect()
                    .tint(.red)
                }
            }
            .padding()
            .frame(width: 200, height: 200)
            .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            
            VStack {
                Text("ATTENDENTS")
                    .font(.caption2)
                    .fontWidth(.expanded)
                    .multilineTextAlignment(.center)
                Spacer()
                Image(systemName: "bell")
                    .font(.system(size: 36))
                Text("$\(modifiableUserData.wrappedValue.weeklyFlightAttendentSalary.withCommas)/week")
                    .fontWidth(.condensed)
                    .contentTransition(.numericText(countsDown: true))
                Text("\(String(Int(modifiableUserData.wrappedValue.flightAttendentHappiness * 100)))%")
                    .fontWidth(.condensed)
                    .contentTransition(.numericText(countsDown: true))
                Spacer()
                /// Flight attendent pricing logic
                /// To implement in v1
                HStack {
                    Button {
                        var adder: Double = 0
                        if modifiableUserData.wrappedValue.flightAttendentHappiness != 1 {
                            adder = Double.random(in: 0.01...0.05)
                            while adder + modifiableUserData.wrappedValue.flightAttendentHappiness > 1 {
                                adder = Double.random(in: 0.01...0.05)
                            }
                        }
                        withAnimation {
                            modifiableUserData.wrappedValue.weeklyFlightAttendentSalary = modifiableUserData.wrappedValue.weeklyFlightAttendentSalary + 50
                            modifiableUserData.wrappedValue.flightAttendentHappiness = modifiableUserData.wrappedValue.flightAttendentHappiness + adder
                        }
                    } label: {
                        Spacer()
                        Image(systemName: "arrowtriangle.up")
                        Spacer()
                    }
                    .adaptiveProminentButtonStyle()
                    .hoverEffect()
                    .tint(.green)
                    
                    Button {
                        var adder: Double = 0
                        if modifiableUserData.wrappedValue.flightAttendentHappiness != 1 {
                            adder = Double.random(in: 0.01...0.05)
                            while adder + modifiableUserData.wrappedValue.flightAttendentHappiness > 1 {
                                adder = Double.random(in: 0.01...0.05)
                            }
                        }
                        withAnimation {
                            modifiableUserData.wrappedValue.weeklyFlightAttendentSalary = modifiableUserData.wrappedValue.weeklyFlightAttendentSalary - 50
                            modifiableUserData.wrappedValue.flightAttendentHappiness = modifiableUserData.wrappedValue.flightAttendentHappiness - adder
                        }
                    } label: {
                        Spacer()
                        Image(systemName: "arrowtriangle.down")
                        Spacer()
                    }
                    .adaptiveProminentButtonStyle()
                    .hoverEffect()
                    .tint(.red)
                }
            }
            .padding()
            .frame(width: 200, height: 200)
            .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            
            VStack {
                Text("MAINTENANCE")
                    .font(.caption2)
                    .fontWidth(.expanded)
                    .multilineTextAlignment(.center)
                Spacer()
                Image(systemName: "wrench.and.screwdriver")
                    .font(.system(size: 36))
                Text("$\(modifiableUserData.wrappedValue.weeklyFlightMaintainanceCrewSalary.withCommas)/week")
                    .fontWidth(.condensed)
                    .contentTransition(.numericText(countsDown: true))
                Text("\(String(Int(modifiableUserData.wrappedValue.maintainanceCrewHappiness * 100)))%")
                    .fontWidth(.condensed)
                    .contentTransition(.numericText(countsDown: true))
                Spacer()
                /// Maintainance crew salary logic
                /// To implement in v1
                HStack {
                    Button {
                        var adder: Double = 0
                        if modifiableUserData.wrappedValue.maintainanceCrewHappiness != 1 {
                            adder = Double.random(in: 0.01...0.05)
                            while adder + modifiableUserData.wrappedValue.maintainanceCrewHappiness > 1 {
                                adder = Double.random(in: 0.01...0.05)
                            }
                        }
                        withAnimation {
                            modifiableUserData.wrappedValue.weeklyFlightMaintainanceCrewSalary = modifiableUserData.wrappedValue.weeklyFlightMaintainanceCrewSalary + 50
                            modifiableUserData.wrappedValue.maintainanceCrewHappiness = modifiableUserData.wrappedValue.maintainanceCrewHappiness + adder
                        }
                    } label: {
                        Spacer()
                        Image(systemName: "arrowtriangle.up")
                        Spacer()
                    }
                    .adaptiveProminentButtonStyle()
                    .hoverEffect()
                    .tint(.green)
                    
                    Button {
                        var adder: Double = 0
                        if modifiableUserData.wrappedValue.maintainanceCrewHappiness != 1 {
                            adder  = Double.random(in: 0.01...0.05)
                            while adder + modifiableUserData.wrappedValue.maintainanceCrewHappiness > 1 {
                                adder = Double.random(in: 0.01...0.05)
                            }
                        }
                        withAnimation {
                            modifiableUserData.wrappedValue.weeklyFlightMaintainanceCrewSalary = modifiableUserData.wrappedValue.weeklyFlightMaintainanceCrewSalary - 50
                            modifiableUserData.wrappedValue.maintainanceCrewHappiness = modifiableUserData.wrappedValue.maintainanceCrewHappiness - adder
                        }
                    } label: {
                        Spacer()
                        Image(systemName: "arrowtriangle.down")
                        Spacer()
                    }
                    .adaptiveProminentButtonStyle()
                    .hoverEffect()
                    .tint(.red)
                }
            }
            .padding()
            .frame(width: 200, height: 200)
            .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
        }
    }
}

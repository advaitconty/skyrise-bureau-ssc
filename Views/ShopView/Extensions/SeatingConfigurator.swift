//
//  SeatingConfigurator.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/12/25.
//

import SwiftUI
import CompactSlider

extension ShopView {
    func seatingConfiguratorItem(numberToChange: Binding<Int>, icon: String) -> some View {
            HStack {
                CompactSlider(value: Binding(get: {
                    return Float(numberToChange.wrappedValue)
                }, set: {
                    numberToChange.wrappedValue = Int($0)
                    
                }), in: 0...Float(selectedPlane!.maxSeats), step: 1)
                .compactSliderStyle(default: .horizontal(.leading))
                .frame(height: 20)
                Image(systemName: icon)
                Text("\(numberToChange.wrappedValue)")
                    .fontWidth(.condensed)
                    .contentTransition(.numericText(countsDown: true))
                
                HStack {
                    Button {
                        withAnimation {
                            if selectedPlane!.maxSeats != numberToChange.wrappedValue {
                                numberToChange.wrappedValue -= 1
                            }
                        }
                    } label: {
                        Image(systemName: "minus")
                            .frame(width: 10, height: 10)
                    }
                    .tint(.red)
                    .hoverEffect()
                    .adaptiveProminentButtonStyle()
                    
                    Button {
                        withAnimation {
                            if selectedPlane!.maxSeats != numberToChange.wrappedValue {
                                numberToChange.wrappedValue += 1
                            }
                        }
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 10, height: 10)
                    }
                    .tint(.green)
                    .hoverEffect()
                    .adaptiveProminentButtonStyle()
                }
            }
    }
    
    func seatingConfiguration() -> some View {
        VStack {
            Text("Seating Configuration")
                .fontWidth(.expanded)
            
            VStack {
                seatingConfiguratorItem(numberToChange: $preferedSeatingConfig.economy, icon: "carseat.right")
                seatingConfiguratorItem(numberToChange: $preferedSeatingConfig.premiumEconomy, icon: "star")
                seatingConfiguratorItem(numberToChange: $preferedSeatingConfig.business, icon: "briefcase")
                seatingConfiguratorItem(numberToChange: $preferedSeatingConfig.first, icon: "crown")
            }
            .onChange(of: preferedSeatingConfig) {
                if Int(preferedSeatingConfig.seatsUsed) > selectedPlane!.maxSeats {
                    withAnimation {
                        showAllSeatsFilled = true
                    }
                } else {
                    withAnimation {
                        showAllSeatsFilled = false
                    }
                }
                
                if Int(preferedSeatingConfig.seatsUsed) < selectedPlane!.maxSeats {
                    withAnimation {
                        showNotAllSeatsFullWarning = true
                    }
                } else {
                    withAnimation {
                        showNotAllSeatsFullWarning = false
                    }
                }
            }
        }
        .padding()
        .background(
            colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        
    }
}
